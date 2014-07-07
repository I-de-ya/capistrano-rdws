# encoding: utf-8
namespace :load do
  task :defaults do
    set :unicorn_pid, -> { "#{current_path}/tmp/pids/unicorn.pid" }
  end
end

namespace :unicorn do

  def run_unicorn
    within release_path do
      execute :bundle, "exec unicorn -D -c #{current_path}/config/unicorn.rb -E #{fetch(:rails_env)}"
    end
  end

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      run_unicorn
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      if test "[ -f #{fetch(:unicorn_pid)} ]"
        execute :kill, "-QUIT `cat #{fetch(:unicorn_pid)}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{fetch(:unicorn_pid)} ]"
        execute :kill, "-9 `cat #{fetch(:unicorn_pid)}`"
        execute :rm, fetch(:unicorn_pid)
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{fetch(:unicorn_pid)} ]"
        execute :kill, "-USR2 `cat #{fetch(:unicorn_pid)}`"
      else
        run_unicorn
      end
    end
  end

end
