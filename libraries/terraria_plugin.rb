#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise'

module TerrariaCookbook
  module Resource
    # A resource which manages Terraria server plugins.
    # @since 1.1
    class TerrariaPlugin < Chef::Resource
      include Poise(fused: true)
      provides(:terraria_plugin)

      property(:owner, kind_of: String, default: 'terraria')
      property(:group, kind_of: String, default: 'terraria')
      property(:plugin_name, kind_of: String, name_attribute: true)
      property(:plugin_directory, kind_of: String, default: '/home/terraria/ServerPlugins')
      property(:remote_url, kind_of: String, required: true)
      property(:remote_checksum, kind_of: String)

      def plugin_path
        ::File.join(plugin_directory, plugin_name)
      end

      action(:create) do
        notifying_block do
          directory new_resource.plugin_directory do
            owner new_resource.owner
            group new_resource.group
            mode '0755'
          end

          remote_file new_resource.plugin_path + '.dll' do
            source new_resource.remote_url
            checksum new_resource.remote_checksum
            owner new_resource.owner
            group new_resource.group
          end
        end
      end

      action(:remove) do
        notifying_block do
          file new_resource.plugin_path do
            action :delete
          end
        end
      end
    end
  end
end
