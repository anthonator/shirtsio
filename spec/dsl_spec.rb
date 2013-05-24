require 'spec_helper'

describe Shirtsio::DSL::QueryBuilder do
  it "should build a query without an index" do
    query = Shirtsio::Utils.build_query(Shirtsio::DSL::QueryBuilder.new([:a_method], nil) do |builder|
      builder.a_method 'value'
    end.to_hash)
    query.should == 'a_method=value'
  end

  it "should build a query with an index" do
    query = Shirtsio::Utils.build_query(Shirtsio::DSL::QueryBuilder.new([:a_method], :a_method) do |builder|
      builder.a_method 'value'
    end.to_hash)
    URI::unescape(query).should == 'a_method[0]=value'
  end

  it "should allow for nested methods" do
    query = Shirtsio::Utils.build_query(Shirtsio::DSL::QueryBuilder.new([:a_method => [:b_method]]) do |builder|
      builder.a_method do |builder|
        builder.b_method 'value'
      end
    end.to_hash)
    URI::unescape(query).should == 'a_method[b_method]=value'
  end

  it "should allow for nested methods with arrays" do
    query = Shirtsio::Utils.build_query(Shirtsio::DSL::QueryBuilder.new([:a_method => [:b_method]]) do |builder|
      builder.a_method do |builder|
        builder.b_method ['value']
      end
    end.to_hash)
    URI::unescape(query).should == 'a_method[b_method][0]=value'
  end
end
