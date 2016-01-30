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
      property(:directory, kind_of: String, default: '/home/terraria')

      property(:version, kind_of: String, required: true)
      property(:install_method, equal_to: %w{binary}, default: 'binary')
      property(:binary_url, kind_of: String)
      property(:binary_checksum, kind_of: String)

      property(:ip, kind_of: String, default: '0.0.0.0')
      property(:port, kind_of: Integer, default: 7_777)
      property(:auto_create, equal_to: [true, false], default: true)
      property(:config_path, kind_of: String, default: '/home/terraria/ServerConfig.json')
      property(:force_update, equal_to: [true, false], default: false)
      property(:max_players, kind_of: Integer, default: 8)
      property(:world_name, kind_of: String, default: 'Knot')

      def world_path
        ::File.join(directory, 'My Games', 'Worlds')
      end

      def command
        ['/usr/bin/mono',
         '/opt/terraria/current/TerrariaServer.exe',
         "-config #{config_path}",
         "-worldpath #{world_path}"].tap do |c|
          c << ['-ip', ip] if ip
          c << ['-port', port] if port
          c << ['-worldname', world_name] if world_name
          c << '-forceupdate' if force_update
        end.flatten.join(' ')
      end
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
          directory new_resource.world_path do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0755'
          end

          libartifact_file 'terraria' do
            install_path '/opt'
            artifact_version new_resource.version
            remote_url new_resource.binary_url % { version: new_resource.version  }
            remote_checksum new_resource.binary_checksum
          end
        end
        super
      end

      private
      def service_options(service)
        service.command(new_resource.command)
        service.environment(PATH: '/usr/local/bin:/usr/bin')
        service.user(new_resource.user)
        service.directory(new_resource.directory)
      end
    end
  end
end
