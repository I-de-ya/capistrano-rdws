# encoding: utf-8
namespace :db do
  namespace :data do
    desc 'Make yaml_db dump'
    task :dump do
      on roles(:db) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "db:data:dump"
          end
        end
      end
    end

    desc 'Make yaml_db dump and copy it on development machine'
    task :fetch_fresh_dump do
      require 'active_support/all'
      invoke "db:data:dump"

      user = roles(:web)[0].user
      hostname = roles(:web)[0].hostname
      port = fetch(:ssh_options)[:port]
      port_string = "-P #{port}" if port.present?
      scp_command = ["scp", port_string, "#{user}@#{hostname}:#{current_path}/db/data.yml db/"].compact.join(' ')

      run_locally do
        execute scp_command
      end
    end
  end

  desc 'create db'
  task :create do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # add test for existing db
          # if test
          execute :rake, "db:create"
          # else
          # end
        end
      end
    end
  end

  desc 'reset db'
  task :reset_db do

    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # add test for existing db
          # if test
          ask(:make_reset_db?, "yes[y]да[д]")
          if %(yes y д да).include? fetch(:make_reset_db?)
            execute :rake, "db:reset_db"
          end
          # else
          # end
        end
      end
    end
  end

end
