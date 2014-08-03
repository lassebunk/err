# Err

Err helps you try out and use different error notification gems without the hassle of individual setup.
It adds a simple API that you can use to set up all your notification gems in one place.

Err works with or without Rails.

**Supported services:** [Airbrake](https://github.com/airbrake/airbrake), [Honeybadger](https://github.com/honeybadger-io/honeybadger-ruby) and [Opbeat](https://github.com/opbeat/opbeat_ruby).
If you use a service that isn't listed here, please [add it](#contributing) so others can use it too. Thanks :heart:

## Installation

Add this line to your application's Gemfile:

    gem 'err'

And then execute:

    $ bundle

## Usage

To use a service, just add its Ruby gem to your *Gemfile* and set it up as shown below.

Example configuration, in an initializer, e.g. *config/initializers/err.rb*:

```ruby
Err.configure do |config|
  # Set up shared configuration
  config.environments = %w{ staging production }
  config.ignore << "Some::Exception"

  # Set up Airbrake
  config.airbrake do |config|
    config.api_key = 'some key'
  end

  # Set up Honeybadger
  config.honeybadger do |config|
    config.api_key = 'some key'
  end

  # Set up Opbeat
  config.opbeat do |config|
    config.organization_id = 'some organization id'
    config.app_id = 'some app id'
    config.secret_token = 'some secret token'
  end
end
```

If you prefer to have the individual services set up in different initializers, you can do the following:

```ruby
Err.configure :airbrake do |config|
  config.api_key = 'some key'
end
```

To remove a service, you just remove its Ruby gem from the *Gemfile*. You can leave the config if you wish, so you can use it at a later time. It won't get called if the service's Ruby gem isn't available.

### In Rails projects

## Defaults

Err sets up some defaults that makes it easy to try out new services without the common setup.

#### Ignored exceptions by default

#### Default notification environments

## Manually tracking exceptions

The various error notification gems will track errors automatically. In addition, Err adds a simple API for tracking exceptions and messages manually.

#### Sending an exception

The following will send an exception to all available services:

```ruby
begin
  # Some failing code
rescue => e
  Err.notify e, some_param: "Some value"
end
```

#### Sending a message

You can send a message manually that isn't an actual exception to all services:

```ruby
Err.message "Something went wrong", this_is: "A param"
```

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