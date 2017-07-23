include_recipe 'apache2-windows::default'

apache2_windows_virtualhost 'server1' do
  docroot 'c:\Program Files (x86)\Apache Software Foundation\Apache2.4\htdocs'
  allow_overrides ['all']
  loglevel 'debug'
end

apache2_windows_virtualhost 'server2' do
  template_cookbook 'test'
  template 'site.erb'
  docroot 'c:\Program Files (x86)\Apache Software Foundation\Apache2.4\htdocs'
  allow_overrides ['all']
  loglevel 'debug'
  admin 'admin@server2.com'
end
