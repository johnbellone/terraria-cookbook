#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise'

module TerrariaCookbook
  module Resource
    class TerrariaService < Chef::Resource
      include Poise
      provides(:terraria_service)
      include PoiseService::ServiceMixin

      property(:user, kind_of: String, default: 'terraria')
      property(:group, kind_of: String, default: 'terraria')
      property(:directory, kind_of: String, default: '/home/terraria')

      property(:version, kind_of: String, required: true)
      property(:install_method, equal_to: %w{binary}, default: 'binary')
      property(:binary_url, kind_of: String)
      property(:binary_checksum, kind_of: String)
    end
  end

  module Provider
    class TerrariaService < Chef::Provider
      include Poise
      provides(:terraria_service)
      include PoiseService::ServiceMixin

      def action_enable
        include_recipe 'mono::default', 'libartifact::default'
        notifying_block do
          libartifact_file 'TShock' do
            install_path new_resource.directory
            artifact_version new_resource.version
            owner new_resource.user
            group new_resource.group
            remote_url new_resource.binary_url
            remote_checksum new_resource.binary_checksum
          end
        end
        super
      end

      private
      def service_options(service)
        service.command('/usr/bin/mono TerrariaServer.exe')
        service.user(new_resource.user)
        service.directory(new_resource.directory)
      end
    end
  end
end
