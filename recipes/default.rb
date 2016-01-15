#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
include_recipe 'chef-sugar::default'
include_recipe 'apt::default' if debian?
include_recipe 'yum-centos::default' if centos?

poise_service_user node['terraria']['service_user'] do
  group node['terraria']['service_group']
end

terraria_service node['terraria']['service_name'] do |r|
  user node['terraria']['service_user']
  group node['terraria']['service_group']
  node['terraria']['service'].each_pair { |k,v| r.send(k,v) }
end
