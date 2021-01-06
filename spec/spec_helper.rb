# frozen_string_literal: true
require 'sign_up_and_log_in_helper.rb'

ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require 'pg'
require 'launchy'
require_relative '../database_connection_setup.rb'
require 'database_connection'
require_relative '../clear_tables.rb'

RSpec.configure do |config|
  config.before(:each) do
    clear_table
  end
end

Capybara.app = MakersBnB
