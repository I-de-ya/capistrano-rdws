# Capistrano::Rdws

Bunch of capistrano v3.x tasks

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-rdws', '0.0.20', github: 'I-de-ya/capistrano-rdws'

And then execute:

    $ bundle

Or install it yourself as (but freshier version of gem is on github, not rubygems.org, better use Gemfile):

    $ gem install capistrano-rdws

## Usage

Full list of tasks (some of them are descripted below):

    $ cap db:data:dump
    $ cap db:data:fetch_fresh_dump
    $ cap db:create
    $ cap db:reset_db

    $ cap release:pack

    $ cap unicorn:start
    $ cap unicorn:stop
    $ cap unicorn:force_stop
    $ cap unicorn:restart

    $ cap logs:tail[logfile]

    $ cap system:check_free_space

    $ cap uploads:download
    $ cap uploads:upload

### Db tasks

#### Data tasks (connected with yaml_db gem)
Make `rake db:data:dump` task on server:

    $ cap db:data:dump

Effect of `cap db:data:dump` task plus download `data.yml` into local `db/` application directory:

    $ cap db:data:fetch_fresh_dump

### Uploads tasks

Now [rsync](http://en.wikipedia.org/wiki/Rsync) is used by gem for synchronizing uploads.

Synchronize your local `public/uploads` with remote one (download from remote server)

    $ cap uploads:transmit:from

Also you can synchronize any folder from `/public` with passing argument to task, e.g.:

    $ cap uploads:transmit:from[system]

Synchronize remote `public/uploads` with local one (upload on remote server)

    $ cap uploads:transmit:to

And synchronizing any folder from '/public' also possible with passing argument:

    $ cap uploads:transmit:to[system]

## TODO

1. Test db existance for 'cap db:create'
2. Add task for synchronising public/uploads and public/system (between any 2 environments)
3. Add task for download fresh dump (with yaml_db) from production to staging
4. Add diagnostic tasks for informing about free disc space (and maybe other metrics).
5. Change question in `cap db:reset_db` task
6. Add diagnostic task for informing about number of releases and size of each (or maybe total release size) and size of /shared
7. Speed up assets precompiling with http://stackoverflow.com/questions/9016002/speed-up-assetsprecompile-with-rails-3-1-3-2-capistrano-deployment
8. Add mechanism of partial database dumping for `cap db:data:fetch_fresh_dump`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
