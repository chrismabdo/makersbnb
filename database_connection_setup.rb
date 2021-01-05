require './lib/database_connection.rb'

if ENV['RACK_ENV'] == 'test'
  DatabaseConnection.setup('makersbnb_test')
else
  DatabaseConnection.setup('makersbnb')
end
