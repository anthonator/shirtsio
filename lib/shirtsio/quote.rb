# Provides an exact quote before placing an order.
class Shirtsio::Quote < Shirtsio::Endpoint
  # Get a quote for specified garments.
  #
  # This method specifies a DSL for building the parameters necessary for
  # retrieving a quote.
  #
  # Example:
  #
  #  Shirtsio::Quote.create do |quote|
  #    quote.garment do |garment|
  #      garment.product_id 1
  #      garment.color 'Grey'
  #      garment.sizes do |size|
  #        size.med 1
  #      end
  #    end
  #    quote.print do |print|
  #      print.front do |front|
  #        front.color_count 1
  #        front.colors ['Black']
  #      end
  #    end
  #    quote.ship_type 'Rush'
  #  end
  def self.create(&block)
    query = Shirtsio::DSL::QueryBuilder.new(Shirtsio::DSL::QUOTE, :garment, &block).to_hash
    new(Shirtsio.get('/quote/', query))
  end
end
