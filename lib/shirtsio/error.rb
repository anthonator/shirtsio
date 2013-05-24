module Shirtsio
  # Custom error class for rescuing from all known shirts.io errors
  class Error < StandardError; attr_accessor :result, :error end

  # Raised when shirts.io returns HTTP status code 400
  class BadRequest < Error; end

  # Raised when shirts.io returns HTTP status code 401
  class Unauthorized < Error; end

  # Raised when shirts.io returns HTTP status code 402
  class RequestFailed < Error; end
end
