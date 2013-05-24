require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] = 'test'

require 'tempfile'
require 'shirtsio'

# Require supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|

end
