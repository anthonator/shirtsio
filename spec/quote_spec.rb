require 'spec_helper'

describe Shirtsio::Quote do
  it "should retrieve a quote" do
    quote = Shirtsio::Quote.create do |quote|
      quote.print_type 'Digital Print'
      quote.garment do |garment|
        garment.product_id 1
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
      end
    end
    quote.class.should == Shirtsio::Quote
  end
end
