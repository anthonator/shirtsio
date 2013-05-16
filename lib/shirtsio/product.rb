class Shirtsio::Product < Shirtsio::Endpoint
  # Get product catalog information for a specific product id.
  #
  # @return [Shirtsio::Product] a complete product object
  def self.find(id)
    new(Shirtsio.get("/products/#{id}/"))
  end

  class Simple < Shirtsio::Endpoint
    # Get the complete product object.
    #
    # @return [Shirtsio::Product] a complete product object
    def full_product
      Shirtsio::Product.find(product_id)
    end
  end

  class Category < Shirtsio::Endpoint
    # Get a list of products in the current category.
    #
    # @note This endpoint does not return complete product objects
    # @see {Shirtsio::Product::Simple#full_product}
    # @return [Array] an array of simple product objects
    def products
      products = []
      response = Shirtsio.get("/products/category/#{category_id}/")
      response.each do |product|
        products << Shirtsio::Product::Simple.new(product)
      end
    end

    # Get a list of all available product categories.
    #
    # @return [Array] an array of category objects
    def self.list
      categories = []
      response = Shirtsio.get('/products/category/')
      response.each do |category|
        categories << new(category)
      end
      categories
    end
  end
end
