module Shirtsio
  module Request
    def get(path, options = {}, headers = {})
      request(:get, path, options, headers)
    end

    def post(path, options = {}, headers = {})
      request(:post, path, options, headers)
    end

    private
    # Perform an HTTP request
    def request(method, path, options, headers)
      headers.merge!({
        'User-Agent' => user_agent
      })

      options.merge!({
        :api_key => api_key
      })

      response = connection.send(method) do |request|
        request.url "#{endpoint}#{path}", options
        request.body = options
        request.headers = headers
      end
      Shirtsio::Utils.handle_api_error(response) if response.status != 200

      Shirtsio::Utils.parse_json(response.body)[:result]
    end
  end
end
