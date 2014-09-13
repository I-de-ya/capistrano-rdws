# encoding: utf-8
namespace :uploads do
  namespace :transmit do

    require 'active_support/core_ext/object/blank'

    def user
      roles(:web)[0].user
    end

    def hostname
      roles(:web)[0].hostname
    end

    def port
      fetch(:ssh_options)[:port]
    end

    def ssh_string
      return 'ssh' if port.nil?
      "ssh -p #{port}"
    end

    def remote_public_path
      "#{user}@#{hostname}:#{shared_path}/public"
    end

    def transmitted_folder(custom_folder=nil)
      custom_folder.presence || 'uploads'
    end

    task :from, :folder do |t, args|
      run_locally do
        execute "rsync -azvv -e '#{ssh_string}' #{remote_public_path}/#{transmitted_folder(args[:folder])} public/"
      end
    end

    task :to, :folder do |t, args|
      run_locally do
        execute "rsync -azvv public/#{transmitted_folder(args[:folder])} -e '#{ssh_string}' #{remote_public_path}/"
      end
    end

  end
end