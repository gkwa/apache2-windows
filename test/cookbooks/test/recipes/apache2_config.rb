include_recipe 'apache2-windows::default'

apache2_config 'php' do
  source 'php.conf.erb'
  variables(phpinidir: 'C:\PHP')
end
