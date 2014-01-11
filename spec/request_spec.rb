require 'spec_helper'

describe Shirtsio::Request do
  context "GET" do
    it "should return value on success" do
      stub_request(:get, /https:\/\/www.shirts.io\/api\/v1\/.*/)
        .to_return(body: '{ "result": "success" }', status: 200, headers: { 'Content-Type' => 'application/json' })
      Shirtsio.get('/test').should == 'success'
    end
    
    it "should return BadRequest on 400" do
      stub_request(:get, /https:\/\/www.shirts.io\/api\/v1\/.*/)
        .to_return(body: '{ "result": "failure" }', status: 400, headers: { 'Content-Type' => 'application/json' })
      expect { Shirtsio.get('/test') }.to raise_error(Shirtsio::BadRequest)
    end
    
    it "should return Unauthorized on 401" do
      stub_request(:get, /https:\/\/www.shirts.io\/api\/v1\/.*/)
        .to_return(body: '{ "result": "failure" }', status: 401, headers: { 'Content-Type' => 'application/json' })
      expect { Shirtsio.get('/test') }.to raise_error(Shirtsio::Unauthorized)
    end
    
    it "should return RequestFailed on 402" do
      stub_request(:get, /https:\/\/www.shirts.io\/api\/v1\/.*/)
        .to_return(body: '{ "result": "failure" }', status: 402, headers: { 'Content-Type' => 'application/json' })
      expect { Shirtsio.get('/test') }.to raise_error(Shirtsio::RequestFailed)
    end
    
    it "should return Error for all other errors" do
      stub_request(:get, /https:\/\/www.shirts.io\/api\/v1\/.*/)
        .to_return(body: '{ "result": "failure" }', status: 500, headers: { 'Content-Type' => 'application/json' })
      expect { Shirtsio.get('/test') }.to raise_error(Shirtsio::Error)
    end
  end
  
  context "POST" do
    it "should return value on success" do
      stub_request(:post, /https:\/\/www.shirts.io\/api\/v1\/.*/)
        .to_return(body: '{ "result": "success" }', status: 200, headers: { 'Content-Type' => 'application/json' })
      Shirtsio.post('/test').should == 'success'
    end
  end
end