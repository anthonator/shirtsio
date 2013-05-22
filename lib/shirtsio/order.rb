# Place an order.
class Shirtsio::Order < Shirtsio::Endpoint
  # Create an order
  #
  # This method specifies a DSL for building the parameters necessary for
  # creating an order.
  #
  # @note See documentation provided by shirts.io for a thorough description of all parameters supported by this endpoint.
  #
  # Example:
  #
  #  Shirtsio::Order.create do |order|
  #    order.test true
  #    order.price 18.99
  #    order.print_type 'Digital Print'
  #    order.extra_screens 'None'
  #    order.ship_type 'Standard'
  #    order.garment do |garment|
  #      garment.product_id 1
  #      garment.color 'Black'
  #      garment.sizes do |size|
  #        size.med 1
  #      end
  #    end
  #    order.print do |print|
  #      print.front do |front|
  #        front.artwork ''
  #        front.proof ''
  #        front.color_count 1
  #        front.colors ['Black']
  #        front.dimensions '5.0 inches wide'
  #        front.placement '4.0 inches below bottom of collar'
  #      end
  #    end
  #    order.personalization do |personalization|
  #      personalization.size 'med'
  #      personalization.batch 1
  #      personalization.number 1
  #      personalization.number_size 2
  #      personalization.name 'Bob'
  #      personalization.name_size 1
  #    end
  #    order.addresses do |address|
  #      address.name 'Bob'
  #      address.company 'Sticksnleaves'
  #      address.address '1234 Hopes and Dreams Ln.'
  #      address.address2 'Apt. <3'
  #      address.city 'Indianapolis'
  #      address.state 'IN'
  #      address.country 'US'
  #      address.batch 1
  #      address.sizes do |size|
  #        size.med 1
  #      end
  #    end
  #  end
  # 
  # @see https://www.shirts.io/docs/order_reference/
  def self.create(&block)
    query = Shirtsio::DSL::QueryBuilder.new(Shirtsio::DSL::ORDER, [:garment, :personalization, :addresses], &block).to_hash
    new(Shirtsio.post('/order/', query))
  end
end
