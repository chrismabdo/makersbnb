require_relative 'setup_test_database'

ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require 'pg'

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end

Capybara.app = MakersBnB

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
