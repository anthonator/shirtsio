source 'https://rubygems.org'

# Specify your gem's dependencies in shirtsio.gemspec
gemspec

platforms :rbx do
  gem 'json'
  gem 'psych'
  gem 'racc'
  gem 'rubinius-coverage'
  gem 'rubysl', '~> 2.0'
  gem 'rubysl-test-unit'
end

group :development do
  gem 'bundler'
  gem 'coveralls', :require => false
  gem 'rake'
  gem 'yard'
end

group :test do
  gem 'rspec'
  gem 'simplecov'
end
