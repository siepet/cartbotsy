# Cartbotsy, yo!
Slack bot written in Ruby, gem for Rails app Cart Maker to make shopping in Piotr i Paweł more easy!

# Setup
## Slack
Configure your slack team and get API token and outgoing webhook in order to get cartbotsy to work properly.

## Rails app
Add `cartbotsy` to your `Gemfile`
```ruby
gem 'cartbotsy', git: 'https://github.com/siepet/cartbotsy'
```
Then make a initializer file:
```ruby
# app/config/initializers/cartbotsy.rb
Cartbotsy.configure do |config|
  config.api_token          = 'api_token'
  config.webhook_token      = 'webhook_token'
  config.app_url            = 'app_url'
  config.available_cities   = 'available_cities'
end
```

`api_token` - required, token from slack to make it possible to post to slack channels

`webhook_token` - required, webhook token to make slack call your bot when matching trigger word

`app_url` - required, address to your application so cartbotsy can make API call

`available_cities` - required, an array of cities that can use cartbotsy

# Usage
When ready to run cartbotsy, just type:
```
$ rake cartbotsy:work
```
It should start worker and wait for hooks from slack when trigger word appears in any of the channels.

# License
License can be found in LICENSE file.

# Contributing
Fork & edit & pull request.



