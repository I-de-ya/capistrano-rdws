# encoding: utf-8
namespace :system do
  task :check_free_space do
    on roles(:app) do

      execute "df -h"

      # put here info about predictable growth of disc space and advice for set keep_releases variable (or maybe in another task)
      # count size of each release

      # # code for custom displaying
      #
      # df -h | tail -n+2 | while read fs size used avail rest ; do
      #   if [[ $used ]] ; then
      #     echo $fs $avail'('$size')'
      #   fi
      # done
    end
  end
end