require 'spec_helper'

describe Shirtsio::DSL::QueryBuilder do
  it "should build a proper quote query" do
    query = (Shirtsio::DSL::QueryBuilder.new(Shirtsio::DSL::QUOTE, :garment) do |query|
      query.garment do |garment|
        garment.product_id 1
        garment.color 'Black'
        garment.sizes do |size|
          size.med 1
        end
      end
      query.print do |print|
        print.front do |front|
          front.color_count 1
          front.colors ['Black']
        end
      end
      query.print_type 'Digital Print'
      query.personalization 'Bob'
      query.address_count 1
      query.extra_screens 1
      query.ship_type 'Standard'
      query.international_garment_count 1
    end).to_hash
    CGI::unescape(Faraday::Utils.build_nested_query(query)).should == CGI::unescape(Faraday::Utils.build_nested_query({
      :garment => { 0 => { :product_id => 1, :color => 'Black', :sizes => { :med => 1 } } },
      :print => {
        :front => { :color_count => 1, :colors => { 0 => 'Black' } }
      },
      :print_type => 'Digital Print',
      :personalization => 'Bob',
      :address_count => 1,
      :extra_screens => 1,
      :ship_type => 'Standard',
      :international_garment_count => 1
    }))
  end

  it "should build a proper order query" do
    query = (Shirtsio::DSL::QueryBuilder.new(Shirtsio::DSL::ORDER, [:garment, :addresses, :personalization]) do |query|
      query.test true
      query.price 6000000
      query.garment do |garment|
        garment.product_id 3
        garment.color 'White'
        garment.sizes do |size|
          size.med 2
        end
      end
      query.garment do |garment|
        garment.product_id 3
        garment.color 'White'
        garment.sizes do |size|
          size.med 2
        end
      end
      query.print do |print|
        print.front do |front|
          front.colors ['Black']
          front.color_count 1
          front.artwork 'some_art.png'
          front.proof 'some_proof.png'
        end
        print.left do |left|
          left.colors ['Black']
          left.color_count 1
          left.artwork 'some_art.png'
          left.proof 'some_proof.png'
        end
        print.right do |right|
          right.colors ['Black']
          right.color_count 1
          right.artwork 'some_art.png'
          right.proof 'some_proof.png'
        end
        print.back do |back|
          back.colors ['Black']
          back.color_count 1
          back.artwork 'some_art.png'
          back.proof 'some_proof.png'
        end
      end
      query.addresses do |address|
        address.name 'John Doe'
        address.address '123 Hopes and Dreams Ln.'
        address.address2 'Apt. <3'
        address.city 'Indianapolis'
        address.state 'IN'
        address.zipcode '46244'
        address.country 'US'
        address.batch 1
        address.sizes do |size|
          size.med 2
        end
      end
      query.personalization do |personalization|
        personalization.size 'med'
        personalization.name 'Bob'
        personalization.number 1
        personalization.number_size 4
        personalization.name_size 1
        personalization.batch 1
      end
      query.print_type 'Digital Print'
      query.extra_screens 'Front'
      query.ship_type 'Superrush'
      query.packing_slip 'some_packing_slip.pdf'
    end).to_hash
    CGI::unescape(Faraday::Utils.build_nested_query(query)).should == CGI::unescape(Faraday::Utils.build_nested_query({
      :test => true,
      :price => 6000000,
      :garment => {
        0 => { :product_id => 3, :color => 'White', :sizes => { :med => 2 } },
        1 => { :product_id => 3, :color => 'White', :sizes => { :med => 2 } }
      },
      :print => {
        :front => { :colors => { 0 => 'Black' }, :color_count => 1, :artwork => 'some_art.png', :proof => 'some_proof.png' },
        :left => { :colors => { 0 => 'Black' }, :color_count => 1, :artwork => 'some_art.png', :proof => 'some_proof.png' },
        :right => { :colors => { 0 => 'Black' }, :color_count => 1, :artwork => 'some_art.png', :proof => 'some_proof.png' },
        :back => { :colors => { 0 => 'Black' }, :color_count => 1, :artwork => 'some_art.png', :proof => 'some_proof.png' }
      },
      :addresses => { 0 => { :name => 'John Doe', :address => '123 Hopes and Dreams Ln.', :address2 => 'Apt. <3', :city => 'Indianapolis', :state => 'IN', :zipcode => '46244', :country => 'US', :batch => 1, :sizes => { :med => 2 } } },
      :personalization => { 0 => { :size => 'med', :name => 'Bob', :number => 1, :number_size => 4, :name_size => 1, :batch => 1 } },
      :print_type => 'Digital Print',
      :extra_screens => 'Front',
      :ship_type => 'Superrush',
      :packing_slip => 'some_packing_slip.pdf'
    }))
  end
end
