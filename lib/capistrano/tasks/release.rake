# encoding: utf-8
namespace :release do
  desc "apply all release tasks"
  task :pack do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:stage) do
          # add test for existing db
          # if test
          execute :rake, "release:pack"
          # else
          # end
        end
      end
    end
  end
end
