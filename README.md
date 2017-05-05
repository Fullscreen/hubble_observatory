# HubbleApiClient

HubbleApiClient is a Ruby library to make it easy to interact with the Hubble API.

## Usage

This is a very early version, and right now you are limited to finding
or creating unique Hubble UUID's given a talent account's email and
database id.


## Installation and Configuration

Add this line to your application's Gemfile:

```ruby
gem 'hubble_api_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubble_api_client


HubbleApiClient will require a HUBBLE_API_URL and a HUBBLE_APP_TOKEN which you can obtain from the data team.

1. If you're using this in Rails, you can choose to create an initializer instead and configure the URL and TOKEN as follows:

    ```ruby
    HubbleApiClient.configure do |config|
      config.app_access_token = 'YourAccessToken'
      config.host_url = 'HubbleApiBaseURL'
    end
    ```

### API Overview

#### Use #find_or_create_by! to get a talent account object so we can
find the hubble UUID for that account


```ruby
talent_account = TalentAccount.find_or_create_by!(email: "someone@fullscreen.com", id: 1)
talent_account.uuid # => '123456'

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hubble_api_client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

