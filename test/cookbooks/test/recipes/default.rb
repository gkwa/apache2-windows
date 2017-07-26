include_recipe 'apache2-windows::default'

apache2_windows_virtualhost 'server1' do
  docroot "#{node['apache']['windows']['dir']}/htdocs"
  allow_overrides ['all']
  loglevel 'debug'
end

apache2_windows_virtualhost 'server2' do
  cookbook 'test'
  template 'site.erb'
  docroot "#{node['apache']['windows']['dir']}/htdocs"
  allow_overrides ['all']
  loglevel 'debug'
  admin 'admin@server2.com'
end
