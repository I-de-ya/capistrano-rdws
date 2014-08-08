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

    desc 'Make yaml_db load'
    task :load do
      ask(:confirm, "Вы действительно хотите залить новую базу на сервер #{fetch(:stage)}? (Это уничтожит все текущие данные на сервере) /  Do you really want to deploy data.yml on #{fetch(:stage)} stage? (It will destroy all previous data) ** yes[y]да[д] **")

      on roles(:db) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            if %(yes y д да).include? fetch(:confirm)
              execute :rake, "db:data:load"
            end
          end
        end
      end
    end

    desc 'Copy data.yml from local machine to web server'
    task :download_dump do
      require 'active_support/all'

      user = roles(:web)[0].user
      hostname = roles(:web)[0].hostname
      port = fetch(:ssh_options)[:port]
      port_string = "-P #{port}" if port.present?
      scp_command = ["scp", port_string, "#{user}@#{hostname}:#{current_path}/db/data.yml db/"].compact.join(' ')

      run_locally do
        execute scp_command
      end
    end

    desc 'Copy data.yml from local machine to web server'
    task :upload_dump do

      require 'active_support/all'

      user = roles(:web)[0].user
      hostname = roles(:web)[0].hostname
      port = fetch(:ssh_options)[:port]
      port_string = "-P #{port}" if port.present?
      scp_command = ["scp", port_string, "db/data.yml #{user}@#{hostname}:#{current_path}/db/"].compact.join(' ')

      run_locally do
        execute scp_command
      end
    end

    desc 'Make yaml_db dump and copy it onto development machine'
    task :fetch_fresh_dump do
      invoke "db:data:dump"
      invoke "db:data:download_dump"
    end

    desc 'Copy data.yml from local machine to web server and invoke reset_db task'
    task :deploy_fresh_dump do
      invoke 'db:data:upload_dump'
      invoke 'db:reset_db'
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
          ask(:make_reset_db?, "Вы действительно хотите сделать 'rake db:reset_db' на серверах #{fetch(:stage)}? Это удалит все текущие данные и заменит их на data.yml /  Do you really want to do 'rake db:reset_db' on #{fetch(:stage)} stage? (It will destroy all previous data and replace it with data.yml) ** yes[y]да[д] **")
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
