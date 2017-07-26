resource_name :apache2_config

property :config_name, String, name_property: true
property :conf_dir, String, required: true, default: node['apache']['windows']['conf_dir']
property :cookbook, String
property :source, String
property :variables, Hash, default: {}

action :create do
  directory new_resource.conf_dir

  full_conf_path = "#{new_resource.conf_dir}/#{new_resource.config_name}.conf"

  template "#{full_conf_path}" do
    variables(new_resource.variables)
    source new_resource.source
    cookbook new_resource.cookbook
    action :create
    notifies :create, "template[#{node['apache']['windows']['conf']}]", :immediately
  end

  # fixme: this pains me, there must be better way
  # every chef-client run will re-generate httpd.conf since fileedit() updates
  # httpd.conf then chef-client realizes file is different from template and updates
  # conf, then fileedit() re-appends to httpd.conf
  ruby_block "Append this resource conf to httpd.conf" do
    block do
      this_include = "Include '#{full_conf_path}'"
      httpd_conf = node['apache']['windows']['conf']
      fe = Chef::Util::FileEdit.new("#{httpd_conf}")
      fe.insert_line_if_no_match(/"#{this_include}"/, "Include '#{full_conf_path}'")
      fe.write_file
    end
  end
end

action :delete do
  file "#{new_resource.conf_dir}/#{new_resource.config_name}.conf" do
    action :delete
    notifies :restart, 'service[apache2]'
  end
end
