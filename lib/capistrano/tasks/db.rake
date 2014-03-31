namespace :db do
  namespace :data do
    desc 'Make yaml_db dump'
    task :dump do
      on roles(:db) do
        within release_path do
          with rails_env: fetch(:stage) do
            execute :rake, "db:data:dump"
          end
        end
      end
    end

    desc 'Make yaml_db dump and copy it on development machine'
    task :fetch_fresh_dump do
      invoke "db:data:dump"

      user = roles(:web)[0].user
      hostname = roles(:web)[0].hostname
      port = fetch(:ssh_options)[:port]

      run_locally do
        execute "scp -P #{port} #{user}@#{hostname}:#{current_path}/db/data.yml db/"
      end
    end
  end

  desc 'create db'
  task :create do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:stage) do
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
        with rails_env: fetch(:stage) do
          # add test for existing db
          # if test
          ask :make_reset_db

          execute :rake, "db:reset_db"
          # else
          # end
        end
      end
    end
  end

end