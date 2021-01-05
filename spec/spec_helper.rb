
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

Capybara.app = MakersBnB

RSpec.configure do |config|

  config.after(:each) do
    clear_table
  end
  
  config.expect_with :rspec do |expectations|
   
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
   
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  if config.files_to_run.one?
    
    config.default_formatter = "doc"
  end

end
