module Shirtsio
  module Request
    def get(path, options = {}, headers = {}, raw = false)
      request(:get, path, options, headers, raw)
    end

    private
    # Perform an HTTP request
    def request(method, path, options, headers, raw)
      headers.merge!({
        'User-Agent' => user_agent
      })

      options.merge!({
        :api_key => api_key,
        :test_mode => test_mode
      })

      response = connection.send(method) do |request|
        request.url "#{endpoint}#{path}", options
        request.headers = headers
      end
      Shirtsio::Utils.handle_api_error(response) if response.status != 200

      if raw
        result = response.body
      else
        # The API is returning the "result" encoded as a string rather than
        # object notation so it requires a second pass of the JSON parser
        result = Shirtsio::Utils.parse_json(response.body)
        result = Shirtsio::Utils.parse_json(result[:result])
      end

      result
    end
  end
end
