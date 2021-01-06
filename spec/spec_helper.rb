# frozen_string_literal: true

require_relative 'setup_test_database'

ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require 'pg'
require_relative '../database_connection_setup.rb'
require 'database_connection'
require_relative './spec_spec_spec'

RSpec.configure do |config|
  config.before(:each) do
    clear_table
  end
end

Capybara.app = MakersBnB

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console,
                                                                 # Want a nice code coverage website? Uncomment this next line!
                                                                 SimpleCov::Formatter::HTMLFormatter
                                                               ])
SimpleCov.start
