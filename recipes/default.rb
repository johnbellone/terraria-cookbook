#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
include_recipe 'chef-sugar::default'
include_recipe 'apt::default' if debian?
if rhel?
  include_recipe 'yum::default', 'yum-epel::default'
  include_recipe 'yum-centos::default' if centos?
end

poise_service_user node['terraria']['service_user'] do
  group node['terraria']['service_group']
  home node['terraria']['directory']
end

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
  directory node['terraria']['directory']
  node['terraria']['service'].each_pair { |k,v| r.send(k,v) }
end
