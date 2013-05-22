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
# Assembling the parameters necessary to generate a quote is mess business. Luckily there's a DSL for that.
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
