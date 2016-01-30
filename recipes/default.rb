#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
if platform_family?('debian')
  include_recipe 'apt::default'
  include_recipe 'ubuntu::default' if platform?('ubuntu')
end

if platform_family?('rhel')
  include_recipe 'yum::default', 'yum-epel::default'
  include_recipe 'yum-centos::default' if platform?('centos')
end

group node['terraria']['service_group'] do
  system true
end

user node['terraria']['service_user'] do
  group node['terraria']['service_group']
  home node['terraria']['service']['directory']
  manage_home true
  system true
end

node['terraria']['plugin'].each_pair do |name, url|
  terraria_plugin name.split('_').collect(&:capitalize).join do
    remote_url url
    notifies :restart, "terraria_service[#{node['terraria']['service_name']}]", :delayed
  end
end if node['terraria']['plugin']

terraria_config node['terraria']['service_name'] do |r|
  path node['terraria']['service']['config_path']
  owner node['terraria']['service_user']
  group node['terraria']['service_group']
  node['terraria']['config'].each_pair { |k,v| r.send(k,v) }
  notifies :restart, "terraria_service[#{name}]", :delayed
end

terraria_service node['terraria']['service_name'] do |r|
  user node['terraria']['service_user']
  group node['terraria']['service_group']
  node['terraria']['service'].each_pair { |k,v| r.send(k,v) }
end
