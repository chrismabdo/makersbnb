# frozen_string_literal: true

require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'

class User
  attr_reader :id, :username, :email, :password

  def initialize(id, username, password, email)
    @id = id
    @username = username
    @email = email
    @password = password
  end

  def self.create(username, password, email)
    user = DatabaseConnection.query("INSERT INTO users (username, user_password, user_email) VALUES ('#{username}', '#{password}', '#{email}') RETURNING user_id, user_email, username, user_password;")
    User.new(user[0]['user_id'], user[0]['username'], user[0]['user_password'], user[0]['user_email'])
  end
end
