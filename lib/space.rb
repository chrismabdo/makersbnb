require 'pg'

class Space
  attr_accessor :name, :description, :price

  def initialize(name:, description:, price:)
    @name = name
    @description = description
    @price = price
  end

  def self.show_listings
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    result = connection.exec("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(name: space['name'], description: space['description'], price: space['price'])
    end

  end

  def self.new_listing(name, description, price)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end

    connection.exec("INSERT INTO spaces (name, description, price) VALUES ('#{name}', '#{description}', '#{price}');")
  end
end
