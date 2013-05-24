require 'spec_helper'

describe Shirtsio::Status, :skip_if_travis => true do
  describe Shirtsio::Status::Webhook do
    it "should register a webhook" do
      Shirtsio::Status::Webhook.create('http://www.example.com').should be_true
      Shirtsio::Status::Webhook.delete('http://www.example.com') # teardown
    end

    it "should return a list of webhooks" do
      Shirtsio::Status::Webhook.create('http://www.example.com') # seed
      webhooks = Shirtsio::Status::Webhook.list
      webhooks[0].class.should == Shirtsio::Status::Webhook
      Shirtsio::Status::Webhook.delete('http://www.example.com') # teardown
    end

    it "should delete a webhook" do
      Shirtsio::Status::Webhook.create('http://www.example.com') # seed
      Shirtsio::Status::Webhook.delete('http://www.example.com').should be_true # teardown
    end

    it "should delete a webhook by instance" do
      Shirtsio::Status::Webhook.create('http://www.example.com') # seed
      webhooks = Shirtsio::Status::Webhook.list
      webhooks[0].delete.should be_true
    end
  end
end
