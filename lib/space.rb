# frozen_string_literal: true

require 'pg'
require './lib/user.rb'
require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'

class Space
  attr_accessor :name, :description, :price

  def initialize(id:, name:, description:, price:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.show_listings
    result = DatabaseConnection.query('SELECT * FROM spaces;')
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'], user_id: space['user_id'])
    end
  end

  def self.new_listing(name, description, price, user_id)
    DatabaseConnection.query("INSERT INTO spaces (name, description, price, user_id) VALUES ('#{name}', '#{description}', '#{price}', '#{user_id}');")
  end
end
