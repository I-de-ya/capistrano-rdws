namespace :load do
  task :defaults do
    set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
  end
end


namespace :unicorn do
  # pid_path = "#{current_path}/tmp/pids"
  # unicorn_pid = "#{pid_path}/unicorn.pid"
  unicorn_pid = fetch(:unicorn_pid)

  def run_unicorn
    within release_path do
      execute :bundle, "exec unicorn -D -c config/unicorn.rb -E #{fetch(:stage)}"
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
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-QUIT `cat #{unicorn_pid}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-9 `cat #{unicorn_pid}`"
        execute :rm, unicorn_pid
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-USR2 `cat #{unicorn_pid}`"
      else
        run_unicorn
      end
    end
  end

end