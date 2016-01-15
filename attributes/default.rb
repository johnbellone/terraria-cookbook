#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
default['terraria']['service_user'] = 'terraria'
default['terraria']['service_group'] = 'terraria'
default['terraria']['service_name'] = 'terraria'

default['terraria']['service']['version'] = '4.3.12'
default['terraria']['service']['binary_url'] = "https://github.com/NyxStudios/TShock/releases/download/v%(version)/tshock_%(version).zip"
default['terraria']['service']['binary_checksum'] = '5023be8ab499e449b2be41d35e0cb83fd99d451244374739c32a1ee58025daa0'
