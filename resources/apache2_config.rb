resource_name :apache2_config

property :config_name, String, name_property: true
property :conf_dir, String, required: true, default: node['apache']['windows']['conf_dir']
property :cookbook, String
property :source, String
property :variables, Hash, default: {}

action :create do
  directory new_resource.conf_dir

  node.default['apache']['windows']['conf_dir_include'] = true

  template "#{new_resource.conf_dir}/#{new_resource.config_name}.conf" do
    variables(new_resource.variables)
    source new_resource.source
    cookbook new_resource.cookbook
    action :create
    notifies :create, "template[#{node['apache']['windows']['conf']}]", :immediately
  end
end

action :delete do
  file "#{new_resource.conf_dir}/#{new_resource.config_name}.conf" do
    action :delete
    notifies :restart, 'service[apache2]'
  end
end
