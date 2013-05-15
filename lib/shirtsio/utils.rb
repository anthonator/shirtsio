module Shirtsio
  # @private
  module Utils
    private
    def self.handle_api_error(response)
      result = parse_json(response.body)[:result]
      error = case response.status
      when 400 then BadRequest.new
      else Error.new
      end
      error.description = result
      raise error
    end

    def self.parse_json(json)
      MultiJson.load(json, :symbolize_keys => true)
    end
  end
end
