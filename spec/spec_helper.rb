require 'simplecov'
SimpleCov.start do
  if ENV['CI'] && ENV['TRAVIS']
    add_filter do |source_file|
      ['order_spec.rb', 'order.rb'].include?(File.basename(source_file.filename))
    end
  end
end

ENV['RAILS_ENV'] = 'test'

require 'tempfile'
require 'shirtsio'

# Require supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do
    Shirtsio.configure do |config|
      config.api_key = '...'
    end
  end

  if ENV['CI'] && ENV['TRAVIS']
    config.filter_run_excluding :skip_if_travis => true
  end
end
