after 'deploy:symlink:shared', 'symlink:linked_nfs_files'
after 'deploy:symlink:shared', 'symlink:linked_nfs_dirs'

after 'deploy:check', 'check:linked_nfs_dirs'
after 'deploy:check', 'check:make_linked_nfs_dirs'
after 'deploy:check', 'check:linked_nfs_files'

namespace :symlink do

    desc "Symlink nfs directories"
    task :linked_nfs_dirs do
      next unless any? :linked_nfs_dirs
      on release_roles :root do
        execute :sudo, "/bin/mkdir", "-p", linked_nfs_dir_parents(release_path)
      end
      on release_roles :app do
        execute :mkdir, "-p", linked_nfs_dir_parents(release_path)
      end
      on release_roles :all do
        fetch(:linked_nfs_dirs).each do |dir|
          target = release_path.join(dir)
          source = nfs_path.join(dir)
          next if test "[ -L #{target} ]"
          execute :rm, "-rf", target if test "[ -d #{target} ]"
          execute :ln, "-s", source, target
        end
      end
    end

    desc "Symlink linked files"
    task :linked_nfs_files do
      next unless any? :linked_nfs_files
      on release_roles :root do
        execute :sudo, "/bin/mkdir", "-p", linked_nfs_file_dirs(release_path)
      end
      on release_roles :app do
        execute :mkdir, "-p", linked_nfs_file_dirs(release_path)
      end
      on release_roles :all do
        fetch(:linked_nfs_files).each do |file|
          target = release_path.join(file)
          source = nfs_path.join(file)
          next if test "[ -L #{target} ]"
          execute :rm, target if test "[ -f #{target} ]"
          execute :ln, "-s", source, target
        end
      end
    end

  end

  namespace :check do

    desc "Check directories to be linked exist in shared"
    task :linked_nfs_dirs do
      next unless any? :linked_nfs_dirs
      on release_roles :root do
        execute :sudo, "/bin/mkdir", "-p", linked_nfs_dirs(nfs_path)
      end
      on release_roles :app do
        execute :mkdir, "-p", linked_nfs_dirs(nfs_path)
      end
    end

    desc "Check directories of files to be linked exist in shared"
    task :make_linked_nfs_dirs do
      next unless any? :linked_nfs_files
      on release_roles :root do
        execute :sudo, "/bin/mkdir", "-p", linked_nfs_file_dirs(nfs_path)
      end
      on release_roles :app do
        execute :mkdir, "-p", linked_nfs_file_dirs(nfs_path)
      end
    end

    desc "Check files to be linked exist in shared"
    task :linked_nfs_files do
      next unless any? :linked_nfs_files
      on release_roles :all do |host|
        linked_nfs_files(nfs_path).each do |file|
          unless test "[ -f #{file} ]"
            error t(:linked_nfs_file_does_not_exist, file: file, host: host)
            exit 1
          end
        end
      end
    end

  end