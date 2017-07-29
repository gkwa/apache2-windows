#
# Cookbook:: apache2-windows
# Recipe:: default
#
# Copyright:: 2017, Chef Software, Inc.
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

default['apache']['windows']['vc15']['x86']['2.4.27']['url']       = 'https://www.apachelounge.com/download/VC15/binaries/httpd-2.4.27-Win32-VC15.zip'
default['apache']['windows']['vc15']['x86']['2.4.27']['sha256sum'] = '7ba98a25964b27bca693699f9b563b6de1c7b79525f76befcbec327331b8c6b7'
default['apache']['windows']['vc15']['x86']['2.4.27']['name']      = ''
default['apache']['windows']['vc15']['x64']['2.4.27']['url']       = 'https://www.apachelounge.com/download/VC15/binaries/httpd-2.4.27-Win64-VC15.zip'
default['apache']['windows']['vc15']['x64']['2.4.27']['sha256sum'] = '6d827bf08bc73c45f2471794b75d7a70907a5274a4515285e5b62774331539fc'
default['apache']['windows']['vc15']['x64']['2.4.27']['name']      = ''

default['apache']['windows']['vc14']['x86']['2.4.27']['url']       = 'https://www.apachelounge.com/download/VC14/binaries/httpd-2.4.27-Win32-VC14.zip'
default['apache']['windows']['vc14']['x86']['2.4.27']['sha256sum'] = '200a26d83c1494657e80fe4a1f513dd20430122ef9d4ce0920b87916575b1704'
default['apache']['windows']['vc14']['x86']['2.4.27']['name']      = ''
default['apache']['windows']['vc14']['x64']['2.4.27']['url']       = 'https://www.apachelounge.com/download/VC14/binaries/httpd-2.4.27-Win64-VC14.zip'
default['apache']['windows']['vc14']['x64']['2.4.27']['sha256sum'] = '24475fa957495f5d9847b941349e4a416b8175540041bb1649c453ee07a8a15c'
default['apache']['windows']['vc14']['x64']['2.4.27']['name']      = ''

default['apache']['windows']['vc11']['x86']['2.4.27']['url']       = 'https://www.apachelounge.com/download/VC11/binaries/httpd-2.4.27-Win32-VC11.zip'
default['apache']['windows']['vc11']['x86']['2.4.27']['sha256sum'] = '841666178fdadfba5f3a80320cab512c83cf6aba2190fcd7102a795f8df4163a'
default['apache']['windows']['vc11']['x86']['2.4.27']['name']      = ''
default['apache']['windows']['vc11']['x64']['2.4.27']['url']       = 'https://www.apachelounge.com/download/VC11/binaries/httpd-2.4.27-Win64-VC11.zip'
default['apache']['windows']['vc11']['x64']['2.4.27']['sha256sum'] = '0a3a6843bdf9dc3dd13f0cc9c0f8f43518675a066c23d5de4cee0ab2c50c1feb'
default['apache']['windows']['vc11']['x64']['2.4.27']['name']      = ''

default['apache']['windows']['version']         = '2.4.27'
default['apache']['windows']['x86_override']    = false # if true, then i want 32bit apache on 64bit machine
default['apache']['windows']['dir']             = "#{ENV['PROGRAMFILES']}/Apache Software Foundation/Apache#{node['apache']['windows']['version'].split('.')[0..1].join('.')}"
default['apache']['windows']['package_name']    = "httpd-#{node['apache']['windows']['version']}-Win32-VC14.zip"
default['apache']['windows']['service']         = "Apache#{node['apache']['windows']['version'].split('.')[0..1].join('')}x86"
case node['kernel']['machine']
when 'x86_64'
  if node['apache']['windows']['x86_override']
    default['apache']['windows']['dir'] = "#{ENV['PROGRAMFILES(x86)']}/Apache Software Foundation/Apache#{node['apache']['windows']['version'].split('.')[0..1].join('.')}"
  else
    default['apache']['windows']['package_name'] = "httpd-#{node['apache']['windows']['version']}-Win64-VC14.zip"
    default['apache']['windows']['service']      = "Apache#{node['apache']['windows']['version'].split('.')[0..1].join('')}x64"
  end
end
default['apache']['windows']['bin_dir']         = "#{node['apache']['windows']['dir']}/bin"
default['apache']['windows']['conf_dir']        = "#{node['apache']['windows']['dir']}/conf.d"
default['apache']['windows']['display_name']    = "Apache HTTP Server #{node['apache']['windows']['version']}"
default['apache']['windows']['source']          = "https://www.apachelounge.com/download/VC14/binaries/#{node['apache']['windows']['package_name']}"
default['apache']['windows']['log_dir']         = 'logs' # relative to ServerRoot
default['apache']['windows']['error_log']       = 'error.log'
default['apache']['windows']['access_log']      = 'access.log'
default['apache']['windows']['user']            = 'daemon'
default['apache']['windows']['group']           = 'daemon'
default['apache']['windows']['conf']            = "#{node['apache']['windows']['dir']}/conf/httpd.conf"
default['apache']['windows']['extras_dir']      = "#{node['apache']['windows']['dir']}/conf/extra"
default['apache']['windows']['binary']          = "#{node['apache']['windows']['bin_dir']}/httpd.exe"
default['apache']['windows']['docroot_dir']     = "#{node['apache']['windows']['dir']}/htdocs"
default['apache']['windows']['cgibin_dir']      = "#{node['apache']['windows']['dir']}/cgi-bin"
default['apache']['windows']['icondir']         = "#{node['apache']['windows']['dir']}/icons"
default['apache']['windows']['cache_dir']       = "#{node['apache']['windows']['dir']}/cache"
default['apache']['windows']['ssl_dir']         = "#{node['apache']['windows']['dir']}/ssl"
default['apache']['windows']['pid_file']        = "#{node['apache']['windows']['log_dir']}/httpd.pid"
default['apache']['windows']['lib_dir']         = "#{node['apache']['windows']['dir']}/modules"
default['apache']['windows']['libexecdir']      = node['apache']['windows']['lib_dir']
default['apache']['windows']['serveradmin']     = "admin@#{node['fqdn']}"
default['apache']['windows']['default_modules'] = %w(access_compat actions alias allowmethods asis auth_basic authn_core authn_file authz_core authz_groupfile authz_host authz_user autoindex cgi dir env include isapi log_config mime negotiation setenvif)

# General settings
default['apache']['windows']['listen_ports']      = %w(80)
default['apache']['windows']['listen_addresses']  = %w(*)

# Extras to enable -- these correspond with the extras files that come out of the box
# Supported 'extras': autoindex, mpm, languages, userdir, info, manual, default, ssl
default['apache']['windows']['extras']            = []

default['apache']['windows']['conf_dir_include'] = false
