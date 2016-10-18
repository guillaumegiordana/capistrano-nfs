require "pathname"

module Capistrano
  module NFS
    module DSL
      
      def nfs_path
        Pathname.new fetch(:nfs_path, "#{shared_path}")
      end

      def linked_nfs_dirs(parent)
        paths = fetch(:linked_nfs_dirs)
        join_paths(parent, paths)
      end

      def linked_nfs_files(parent)
        paths = fetch(:linked_nfs_files)
        join_paths(parent, paths)
      end

      def linked_nfs_file_dirs(parent)
        map_dirnames(linked_nfs_files(parent))
      end

      def linked_nfs_dir_parents(parent)
        map_dirnames(linked_nfs_dirs(parent))
      end

    end
  end
end