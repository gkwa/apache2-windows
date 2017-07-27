#
# Cookbook:: apache2-windows
# Recipe:: default
#
# Copyright:: 2013-2017, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/exceptions'

include_recipe 'vcruntime::vc14'

unless node['platform_family'] == 'windows'
  raise Chef::Exceptions::Application, 'This cookbook only works on Microsoft Windows.'
end

zipfile_path = ::File.join(Chef::Config[:file_cache_path], node['apache']['windows']['package_name'])
install_script = "install_apache2_#{node['apache']['windows']['x86_override'] ? 'x86' : 'x64'}.ps1"

remote_file zipfile_path do
  source node['apache']['windows']['source']
end

template "#{ENV['TEMP']}\\#{install_script}" do
  source 'install.ps1.erb'
  variables(
    service: node['apache']['windows']['service'],
    zip_subdir: "Apache#{node['apache']['windows']['version'].split('.')[0..1].join('')}",
    zipfile_path: zipfile_path,
    install_dir: node['apache']['windows']['dir']
  )
end

execute "Extract and install #{node['apache']['windows']['package_name']}" do
  command "powershell -InputFormat None -ExecutionPolicy Bypass -File \"#{ENV['TEMP']}\\#{install_script}\""
  not_if do
    httpd_path = "#{node['apache']['windows']['bin_dir']}/httpd.exe".tr('\\', '/')
    if !::File.exist?(httpd_path)
      false
    else
      cmd = shell_out("\"#{httpd_path}\" -version")
      current = %r{Server version: Apache/((\d+\.)?(\d+\.)?(\*|\d+))}.match(cmd.stdout)[1]
      node['apache']['windows']['version'] == current
    end
  end
end

template node['apache']['windows']['conf'] do
  source 'httpd.conf.erb'
  action :create
  notifies :restart, 'service[apache2]'
end

powershell_script 'Install Apache service' do
  code <<-EOH
  & "#{node['apache']['windows']['bin_dir']}\\httpd.exe" -k install -n "#{node['apache']['windows']['service']}"
  # install service is success message is sent to stderr
  if ($error[0] | Select-String 'service is successfully installed') {
        $error.removeAt(0)
  }
  EOH
end

node['apache']['windows']['extras'].each do |extra|
  include_recipe "apache2-windows::_extra_#{extra}"
end

# Start apache service
service 'apache2' do
  service_name node['apache']['windows']['service']
  action [:enable, :start]
end
