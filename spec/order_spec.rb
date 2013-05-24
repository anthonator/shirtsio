require 'spec_helper'

describe Shirtsio::Order, :skip_if_travis => true do
  it "should create an order" do
    order = Shirtsio::Order.create do |order|
      order.test true
      order.price 28.43
      order.print_type 'Digital Print'
      order.ship_type 'Standard'
      order.garment do |garment|
        garment.product_id 1
        garment.color 'Black'
        garment.sizes do |size|
          size.med 1
        end
      end
      order.print do |print|
        print.front do |front|
          front.artwork File.new(File.expand_path('support/ruby.png', File.dirname(__FILE__)))
          front.proof File.new(File.expand_path('support/ruby.jpg', File.dirname(__FILE__)))
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
        address.name 'Anthony'
        address.company 'Sticksnleaves'
        address.address '1234 Hopes and Dreams Ln.'
        address.address2 'Apt. <3'
        address.city 'Seattle'
        address.state 'Washington'
        address.zipcode 55555
        address.country 'US'
        address.batch 1
        address.sizes do |size|
          size.med 1
        end
      end
    end
    order.class.should == Shirtsio::Order
  end
end
