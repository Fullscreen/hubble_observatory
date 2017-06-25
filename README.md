Hubble Observatory
==================

Hubble Observatory is a Ruby library to interact with the Hubble API.

The **source code** is available on [GitHub](https://github.com/fullscreen/hubble_observatory) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/hubble_observatory/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/hubble_observatory/master.svg)](https://travis-ci.org/Fullscreen/hubble_observatory)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/hubble_observatory/master.svg)](https://coveralls.io/r/Fullscreen/hubble_observatory)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/hubble_observatory.svg)](https://gemnasium.com/Fullscreen/hubble_observatory)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/hubble_observatory.svg)](https://codeclimate.com/github/Fullscreen/hubble_observatory)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/hubble_observatory/frames)
[![Gem Version](http://img.shields.io/gem/v/hubble_observatory.svg)](http://rubygems.org/gems/hubble_observatory)

After [registering your app](https://fullscreen.github.io/hubble_observatory/), you can run commands like:

```ruby
HubbleObservatory::TalentAccount.create email: 'user@example.com'
# => 123456
```

The **full documentation** is available at [rubydoc.info](http://www.rubydoc.info/gems/hubble_observatory/frames).


## Installation and Configuration

Add this line to your application’s Gemfile:

```ruby
gem 'hubble_observatory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubble_observatory

Set the following ENV variables in your Ruby/Rails application

```ruby
ENV['HUBBLE_APP_TOKEN'] = "<app token to access Hubble API>"
ENV['HUBBLE_ENV'] = "production"
```

If you don’t set `ENV['HUBBLE_ENV']` to "production", the staging Hubble API will be targeted.

## How to use

Hubble Observatory provide only two methods to create and update talent accounts.

### TalentAccount.create

Obtain the ID of Talent Account given the corresponding email:

```ruby
talent_account = HubbleObservatory::TalentAccount.create email: 'user@example.com'
# => '123456'
```

### TalentAccount#update

Update the email of a Talent Account give the corresponding ID:

```ruby
talent_account = HubbleObservatory::TalentAccount.new id: '123456'
talent_account.update email: 'newuser@example.com'
# => 123456
```
### FsEmployee#create

Obtain the token of a employee given the appropriate access token:

```ruby
HubbleObservatory::FsEmployee.create access_token: 'ya.29defg'
# => 'hb.484562'
```

## How to develop and contribute

To install the app and its dependencies, run `bin/setup`.

To execute the test suite, run:

```ruby
HUBBLE_APP_TOKEN=<token> bundle exec rake
```

To release a new version, run: `bundle exec rake release`.
