module Shirtsio
  # Custom error class for rescuing from all known shirts.io errors
  class Error < StandardError; attr_accessor :description end

  # Raised when shirts.io returns HTTP status code 400
  class BadRequest < Error; end
end
