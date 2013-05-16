require 'faraday'
require 'hashie'
require 'multi_json'

require 'shirtsio/error'
require 'shirtsio/utils'

require 'shirtsio/configuration'
require 'shirtsio/connection'
require 'shirtsio/request'
require 'shirtsio/api'
require 'shirtsio/endpoint'

require 'shirtsio/product'

module Shirtsio
  extend Configuration

  def self.api(options = {})
    Shirtsio::API.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless api.respond_to?(method)
    api.send(method, *args, &block)
  end

  def self.respond_to?(method)
    api.respond_to?(method) || super
  end
end
