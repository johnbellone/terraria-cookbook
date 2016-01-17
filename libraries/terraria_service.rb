#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise_service/service_mixin'

module TerrariaCookbook
  module Resource
    # A resource which manages the Terraria server service.
    # @since 1.0
    class TerrariaService < Chef::Resource
      include Poise
      provides(:terraria_service)
      include PoiseService::ServiceMixin

      property(:user, kind_of: String, default: 'terraria')
      property(:group, kind_of: String, default: 'terraria')
      property(:directory, kind_of: String, default: '/var/lib/terraria')

      property(:version, kind_of: String, required: true)
      property(:install_method, equal_to: %w{binary}, default: 'binary')
      property(:binary_url, kind_of: String)
      property(:binary_checksum, kind_of: String)
    end
  end

  module Provider
    # A provider which installs the Terraria server service.
    # @since 1.0
    class TerrariaService < Chef::Provider
      include Poise
      provides(:terraria_service)
      include PoiseService::ServiceMixin

      def action_enable
        include_recipe 'mono::default'
        notifying_block do
          directory new_resource.directory do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0755'
          end

          libartifact_file 'terraria' do
            install_path '/opt'
            artifact_version new_resource.version
            owner new_resource.user
            group new_resource.group
            remote_url new_resource.binary_url % { version: new_resource.version  }
            remote_checksum new_resource.binary_checksum
          end
        end
        super
      end

      private
      def service_options(service)
        service.command('/usr/bin/mono /opt/terraria/current/TerrariaServer.exe')
        service.user(new_resource.user)
        service.directory(new_resource.directory)
      end
    end
  end
end
