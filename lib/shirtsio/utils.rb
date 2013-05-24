module Shirtsio
  # @private
  module Utils
    private
    def self.handle_api_error(response)
      result = parse_json(response.body)
      error = case response.status
      when 400 then BadRequest.new
      else Error.new
      end
      error.result = result[:result]
      error.error = result[:error]
      raise error
    end

    def self.parse_json(json)
      MultiJson.load(json, :symbolize_keys => true)
    end

    def self.build_query(hash)
      Faraday::Utils.build_nested_query(hash)
    end
  end
end
