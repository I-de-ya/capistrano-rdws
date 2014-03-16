namespace :db do

  namespace :data do
    task :dump do
      on roles(:db) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "db:data:dump"
          end
        end
      end
    end
  end

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

end