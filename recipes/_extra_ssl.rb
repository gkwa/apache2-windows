#
# Cookbook:: apache2-windows
# Recipe:: _extra_ssl
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

directory node['apache']['windows']['ssl_dir'] do
  recursive true
end

powershell_script 'Create self signed ssl certificate' do
  cwd node['apache']['windows']['dir']
  code <<-EOH
  & "#{node['apache']['windows']['bin_dir']}/openssl.exe" req -nodes -x509 -newkey rsa:4096 `
    -keyout "#{node['apache']['windows']['ssl_dir']}/server.key" `
    -out "#{node['apache']['windows']['ssl_dir']}/server.crt" -days 365 `
    -config conf/openssl.cnf `
    -subj '/C=US/ST=State/O=Company/OU=Department/CN=www.example.com/emailAddress=admin@example.com'
  EOH
  returns [0, 1]
end

template "#{node['apache']['windows']['extras_dir']}/httpd-ssl.conf" do
  source 'httpd-ssl.conf.erb'
  action :create
  notifies :restart, 'service[apache2]'
end
