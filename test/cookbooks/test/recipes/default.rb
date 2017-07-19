include_recipe 'apache2-windows::default'

apache2_windows_virtualhost 'server1' do
  docroot 'c:\Program Files (x86)\Apache Software Foundation\Apache2.4\htdocs'
  allow_overrides ['all']
  loglevel 'debug'
end
