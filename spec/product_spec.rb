require 'spec_helper'

describe Shirtsio::Product, :skip_if_travis => true do
  it "should find a specific product" do
    product = Shirtsio::Product.find(1)
    product.class.should == Shirtsio::Product
  end

  describe Shirtsio::Product::Category do
    it "should return a list of categories" do
      categories = Shirtsio::Product::Category.list
      categories[0].class.should == Shirtsio::Product::Category
    end

    it "should return a list of products" do
      categories = Shirtsio::Product::Category.list
      categories[0].products[0].class.should == Shirtsio::Product::Simple
    end

    it "should return a complete product object" do
      categories = Shirtsio::Product::Category.list
      categories[0].products[0].full_product.class.should == Shirtsio::Product
    end
  end
end
