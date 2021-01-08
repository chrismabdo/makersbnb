# frozen_string_literal: true

require 'pg'
require './lib/user.rb'
require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'

class Space
  attr_accessor :id, :name, :description, :price

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
      Space.new(id: space['space_id'], name: space['name'], description: space['description'], price: space['price'], user_id: space['user_id'])
    end
  end

  def self.new_listing(name, description, price, user_id)
    DatabaseConnection.query("INSERT INTO spaces (name, description, price, user_id) VALUES ('#{name}', '#{description}', '#{price}', '#{user_id}') RETURNING space_id, name, description, price, user_id;")
  end

  def self.request(space_id, guest_id)
    DatabaseConnection.query("INSERT INTO requests (space_id, guest_id) VALUES ('#{space_id}', '#{guest_id}') RETURNING request_id, space_id, guest_id;")
  end

  def self.find(space_id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE space_id='#{space_id}';")
    Space.new(id: result[0]['space_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], user_id: result[0]['user_id'])
  end
end
