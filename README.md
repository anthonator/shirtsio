# Shirtsio

A Ruby wrapper around the shirts.io API

## Documentation

You can view detailed documentation of this library at http://rdoc.info/github/anthonator/shirtsio/frames. We try to make sure that our documentation is up-to-date and thorough. However, we do recommend keeping the [shirts.io API documentation](https://www.shirts.io/docs/overview/) handy.

If you find any discrepency in our documentation please [file an issue](https://github.com/anthonator/shirtsio/issues).

## Installation

Add this line to your application's Gemfile:

    gem 'shirtsio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shirtsio

## Quick Start Guide

Before you can start ordering some sweet shirts you'll need to tell shirts.io who you are.

Grab your super secret API key from the [shirts.io dashboard](https://www.shirts.io/accounts/dashboard/).

Sprinkle some pixie-dust...

```ruby
Shirtsio.configure do |config|
  config.api_key = YOUR_API_KEY
end
```

BAM! Print some shirts!

```ruby
Shirtsio::Order.create do |order|
...
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
