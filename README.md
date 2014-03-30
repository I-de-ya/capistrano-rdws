# Capistrano::Rdws

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-rdws'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-rdws

## Usage

Full list of tasks (description of each below):

    $ cap db:data:dump
    $ cap db:data:fetch_fresh_dump
    $ cap db:create

    $ cap release:pack

    $ cap unicorn:start
    $ cap unicorn:stop
    $ cap unicorn:force_stop
    $ cap unicorn:restart

    $ cap logs:tail[logfile]

### Db tasks

#### Data tasks (connected with yaml_db gem)
Make `rake db:data:dump` task on server:

    $ cap db:data:dump

Effect of `cap db:data:dump` task plus download `data.yml` into local `db/` application directory:

    $ cap db:data:fetch_fresh_dump


## TODO

1. Test db existance for 'cap db:create'
2. Add task for synchronising public/uploads and public/system
3. Add task for download fresh dump (from yaml_db)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
