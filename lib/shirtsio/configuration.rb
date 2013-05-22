module Shirtsio
  # Defines constants and methods related to configuration.
  module Configuration
    VALID_OPTIONS_KEYS = [
      :api_key,
      :endpoint,
      :proxy,
      :user_agent
    ].freeze

    # By default, don't set API key.
    DEFAULT_API_KEY = nil.freeze

    # The endpoint that will be used to authorize a user if none is set.
    DEFAULT_ENDPOINT = 'https://www.shirts.io/api/v1'.freeze

    # By default, don't set a proxy server
    DEFAULT_PROXY = nil.freeze

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "shirtsio gem v#{Shirtsio::VERSION}".freeze

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their
    # default values.
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a
    # block.
    def configure
      yield self
    end

    # Create a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to default.
    def reset
      self.api_key = DEFAULT_API_KEY
      self.endpoint = DEFAULT_ENDPOINT
      self.proxy = DEFAULT_PROXY
      self.user_agent = DEFAULT_USER_AGENT
    end
  end
end
