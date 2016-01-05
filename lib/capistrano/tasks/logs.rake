# encoding: utf-8
namespace :logs do
  desc "tail log file from shared_path/log/logfile.log, e.g. 'rake logs:tail[logfile]'"
  task :tail, :file do |_t, args|
    if args[:file]
      on roles(:app) do
        execute "tail -f #{shared_path}/log/#{args[:file]}.log"
      end
    else
      puts "please specify a logfile e.g: 'rake logs:tail[logfile]'"
      puts "will tail 'shared_path/log/logfile.log'"
      puts "remember if you use zsh you'll need to format it as:"
      puts "rake 'logs:tail[logfile]' (single quotes)"
    end
  end
end
