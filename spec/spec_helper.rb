# Require supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  if Support::Travis::travis?
    add_filter do |source_file|
      ['product_spec.rb', 'product.rb', 'order_spec.rb', 'order.rb', 'status_spec.rb', 'status.rb'].include?(File.basename(source_file.filename))
    end
  end
end

ENV['RAILS_ENV'] = 'test'

require 'tempfile'
require 'shirtsio'

RSpec.configure do |config|
  config.before(:each) do
    Shirtsio.configure do |config|
      config.api_key = '...'
    end
  end

  if Support::Travis::travis?
    config.filter_run_excluding :skip_if_travis => true
  end
end
