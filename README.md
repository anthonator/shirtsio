# Shirtsio [![endorse](http://api.coderwall.com/anthonator/endorsecount.png)](http://coderwall.com/anthonator)

A Ruby wrapper around the shirts.io API

[![Build Status](https://travis-ci.org/anthonator/shirtsio.png?branch=master)](https://travis-ci.org/anthonator/shirtsio) [![Code Climate](https://codeclimate.com/github/anthonator/shirtsio.png)](https://codeclimate.com/github/anthonator/shirtsio) [![Coverage Status](https://coveralls.io/repos/anthonator/shirtsio/badge.png?branch=master)](https://coveralls.io/r/anthonator/shirtsio?branch=master)

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

## Product API

```ruby
# Return details about a specific product
product = Shirtsio::Product.find(3)

# Return a list of categories
categories = Shirtsio::Product::Category.list

# Return a list of products for a specific category
products = categories[0].products

# Since shirts.io doesn't return full product data when requesting from a category, return it now
product = products[0].full_product
```

## Quote API

```ruby
# Assembling the parameters necessary to generate a quote is messy
# business. Luckily there's a DSL for that.
quote = Shirtsio::Quote.create do |quote|
  quote.print_type 'Digital Print'
  quote.garment do |garment|
    garment.product_id 3
    garment.color 'Black'
    garment.sizes do |size|
      size.med 1
    end
  end
  quote.print do |print|
    print.front do |front|
      front.color_count 1
      front.colors ['Black']
    end
    print.back do |back|
      back.color_count 1
      back.colors ['Black']
    end
  end
end
```

## Order API
```ruby
# Yep, there's one for orders too
order = Shirtsio::Order.create do |order|
  order.test true
  order.price 18.99
  order.print_type 'Digital Print'
  order.extra_screens 'None'
  order.ship_type 'Standard'
  order.garment do |garment|
    garment.product_id 3
    garment.color 'Black'
    garment.sizes do |size|
      size.med 1
    end
  end
  order.print do |print|
    print.front do |front|
      front.artwork File.new('/path/to/file.png')
      front.proof File.new('/path/to/file.jpg')
      front.color_count 1
      front.colors ['Black']
      front.dimensions '5.0 inches wide'
      front.placement '4.0 inches below bottom of collar'
    end
  end
  order.personalization do |personalization|
    personalization.size 'med'
    personalization.batch 1
    personalization.number 1
    personalization.number_size 2
    personalization.name 'Bob'
    personalization.name_size 1
  end
  order.addresses do |address|
    address.name 'Bob'
    address.company 'Sticksnleaves'
    address.address '1234 Hopes and Dreams Ln.'
    address.address2 'Apt. <3'
    address.city 'Indianapolis'
    address.state 'IN'
    address.country 'US'
    address.batch 1
    address.sizes do |size|
      size.med 1
    end
  end
end
```

## Status API
```ruby
# Get an order's status
status = Shirtsio::Status.find(1234)

# Register a status webhook
Shirtsio::Status::Webhook.create('http://www.example.com') #returns true or false

# List webhooks
webhooks = Shirtsio::Status::Webhook.list

# Delete a webhook
Shirtsio::Status::Webhook.delete('http://www.example.com')
# or
webhooks[0].delete
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

[![Sticksnleaves](http://sticksnleaves-wordpress.herokuapp.com/wp-content/themes/sticksnleaves/images/snl-logo-116x116.png)](http://www.sticksnleaves.com)

Dirigible is maintained and funded by [Sticksnleaves](http://www.sticksnleaves.com)

Thanks to all of our [contributors](https://github.com/anthonator/dirigible/graphs/contributors)