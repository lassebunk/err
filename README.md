# Err

Err helps you try out and use different error notification gems without the hassle of individual setup.
It adds a simple API that you can use to set up all your notification gems in one place.

Err works with or without Rails.

**Supported services:** [Airbrake](https://github.com/airbrake/airbrake), [Honeybadger](https://github.com/honeybadger-io/honeybadger-ruby), [Opbeat](https://github.com/opbeat/opbeat_ruby).
If you use a service that isn't listed here, please [add it](#contributing) so others can use it too. Thanks :heart:

## Installation

Add this line to your application's Gemfile:

    gem 'err'

And then execute:

    $ bundle

## Usage

Example configuration, in an initializer, e.g. *config/initializers/err.rb*:

```ruby
Err.configure do |config|
  config.environments = %w{ staging production }
  config.ignore << "Some::Exception"
end
```

### Manually tracking notifications

The various error notification gems will track errors automatically. In addition, Err adds a simple API for tracking exceptions and messages manually.

#### Sending an exception

The following will send an exception to all available services:

```ruby
begin
  # Some failure prone code
rescue => e
  Err.notify e, some_param: "Some value"
end
```

#### Sending a message

You can send a message manually that isn't an actual exception to all services:

```ruby
Err.message "Something went wrong", this_is: "A param"
```

## Defaults

Err sets up some defaults so you don't have to.

#### Ignored exceptions by default

#### Default environments

## Contributing

You are very welcome to add new error notification services so others can use them too.
See the [existing services](https://github.com/lassebunk/err/tree/master/lib/err/services) to see how this is done.

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make your changes
4. Add tests so others don't break it unintentionally
5. Run tests (`rake`)
6. Commit your changes (`git commit -am 'Add feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create a new pull request