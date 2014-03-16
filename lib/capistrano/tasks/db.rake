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

end