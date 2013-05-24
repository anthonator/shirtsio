module Shirtsio
  # @private
  module Connection
    private
    def connection
      options = {
        :ssl => { :verify => true }
      }
      Faraday.new(endpoint, options) do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter :net_http
      end
    end
  end
end
