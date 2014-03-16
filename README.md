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

List of tasks:

    $ cap db:data:dump
    $ cap db:create

    $ cap release:pack

    $ cap unicorn:start
    $ cap unicorn:stop
    $ cap unicorn:force_stop
    $ cap unicorn:restart

    $ cap logs:tail[logfile]

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
