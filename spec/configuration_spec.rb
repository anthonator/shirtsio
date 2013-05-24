require 'spec_helper'

describe Shirtsio::Configuration do
  it "should allow the api_key to be set" do
    Shirtsio.configure do |config|
      config.api_key = 'abcd1234'
    end
    Shirtsio.api_key.should == 'abcd1234'
  end
end
