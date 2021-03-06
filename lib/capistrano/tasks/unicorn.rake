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

  def remove_unused_unicorn_pid
    return unless unicorn_pid_exists?
    process_exists = capture "ps -p `cat #{fetch(:unicorn_pid)}` -u >> /dev/null 2>&1; echo $?"
    execute :rm, fetch(:unicorn_pid) if process_exists != '0'
  end

  def unicorn_pid_exists?
    test "[ -f #{fetch(:unicorn_pid)} ]"
  end

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      remove_unused_unicorn_pid
      if unicorn_pid_exists?
        info 'Unicorn уже запущен'
      else
        run_unicorn
      end
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      remove_unused_unicorn_pid
      if unicorn_pid_exists?
        execute :kill, "-QUIT `cat #{fetch(:unicorn_pid)}`"
      else
        info 'Нет процесса unicorn\'а'
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      remove_unused_unicorn_pid
      if unicorn_pid_exists?
        execute :kill, "-9 `cat #{fetch(:unicorn_pid)}`"
        execute :rm, fetch(:unicorn_pid)
      else
        info 'Нет процесса unicorn\'а'
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      remove_unused_unicorn_pid
      if unicorn_pid_exists?
        execute :kill, "-USR2 `cat #{fetch(:unicorn_pid)}`"
      else
        run_unicorn
      end
    end
  end
end
