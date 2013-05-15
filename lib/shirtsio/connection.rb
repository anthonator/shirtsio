module Shirtsio
  # @private
  module Connection
    private
    def connection
      options = {
        :ssl => { :verify => true }
      }
      Faraday.new(endpoint, options)
    end
  end
end
