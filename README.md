![CI status](https://github.com/anvkos/ipgeobase/actions/workflows/master.yml/badge.svg)
[![Ruby](https://github.com/anvkos/ipgeobase/actions/workflows/main.yml/badge.svg?event=status)](https://github.com/anvkos/ipgeobase/actions/workflows/main.yml)

# Ipgeobase

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ipgeobase`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ipgeobase'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ipgeobase

## Usage

```ruby
ip_meta = Ipgeobase.lookup('77.88.55.55')
ip_meta.city # Moscow
ip_meta.country # Russia
ip_meta.countryCode # RU
ip_meta.lat # 55.7332
ip_meta.lon # 37.5833
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/anvkos/ipgeobase.
