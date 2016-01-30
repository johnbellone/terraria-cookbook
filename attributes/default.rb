#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
default['terraria']['service_user'] = 'terraria'
default['terraria']['service_group'] = 'terraria'
default['terraria']['service_name'] = 'terraria'

default['terraria']['service']['directory'] = '/home/terraria'
default['terraria']['service']['config_path'] = '/home/terraria/ServerConfig.json'
default['terraria']['service']['version'] = '4.3.12'
default['terraria']['service']['binary_url'] = "https://github.com/NyxStudios/TShock/releases/download/v%{version}/tshock_%{version}.zip"
default['terraria']['service']['binary_checksum'] = '5023be8ab499e449b2be41d35e0cb83fd99d451244374739c32a1ee58025daa0'

default['terraria']['config']['options']['UseServerName'] = false
default['terraria']['config']['options']['AllowLoginAnyUsername'] = true
default['terraria']['config']['options']['AllowRegisterAnyUsername'] = true

default['terraria']['plugin'] = {
  'essentials+' => 'https://tshock.co/xf/index.php?resources/essentials.6/download&version=322',
  'server_events' => 'https://tshock.co/xf/index.php?resources/server-events.147/download&version=572',
  'auto_boss+' => 'https://tshock.co/xf/index.php?resources/autoboss.7/download&version=446',
  'critical_hit' => 'https://tshock.co/xf/index.php?resources/critical-hits.122/download&version=412'
}
