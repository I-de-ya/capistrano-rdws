# Capistrano::Rdws

Bunch of capistrano v3.x tasks

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-rdws', '0.0.11', github: 'I-de-ya/capistrano-rdws'

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

### Db tasks

#### Data tasks (connected with yaml_db gem)
Make `rake db:data:dump` task on server:

    $ cap db:data:dump

Effect of `cap db:data:dump` task plus download `data.yml` into local `db/` application directory:

    $ cap db:data:fetch_fresh_dump

## TODO

1. Test db existance for 'cap db:create'
2. Add task for synchronising public/uploads and public/system (between any 2 environments)
3. Add task for download fresh dump (with yaml_db) from production to staging
4. Add diagnostic tasks for informing about free disc space (and maybe other metrics).
5. Change question in `cap db:reset_db` task
6. Add diagnostic task for informing about number of releases and size of each (or maybe total release size) and size of /shared

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
