# frozen_string_literal: true

require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'
require 'bcrypt'

class User
  attr_reader :id, :username, :email, :password

  def initialize(id:, username:, password:, email:)
    @id = id
    @username = username.capitalize
    @email = email
    @password = password
  end

  def self.create(username, password, email)
    encrypted_password = BCrypt::Password.create(password)
    user = DatabaseConnection.query("INSERT INTO users (username, user_password, user_email) VALUES ('#{username.downcase}', '#{encrypted_password}', '#{email.downcase}') RETURNING user_id, user_email, username, user_password;")
    User.new(id: user[0]['user_id'], username: user[0]['username'], password: user[0]['user_password'], email: user[0]['user_email'])
  end

  def self.copy_check(username, email)
    false unless user_check(username) == true || email_check(email) == true
  end

  def self.user_check(username)
    user_check = DatabaseConnection.query("SELECT * FROM users WHERE username='#{username.downcase}';")
    check = user_check.map do |_name|
      true if name = username
    end
    check[0]
  end

  def self.email_check(email)
    email_check = DatabaseConnection.query("SELECT * FROM users WHERE user_email='#{email.downcase}';")
    check = email_check.map do |_address|
      true if address = email
    end
    check[0]
  end

  def self.check_password(email, given_password)
    if email_check(email) == true
      password_check = DatabaseConnection.query("SELECT * FROM users WHERE user_email='#{email.downcase}';")
      BCrypt::Password.new(password_check[0]['user_password']) == given_password
    else
      false
    end
  end

  def self.find(email)
    result = DatabaseConnection.query("SELECT * FROM users WHERE user_email='#{email.downcase}';")
    User.new(id: result[0]['user_id'], username: result[0]['username'], email: result[0]['user_email'], password: result[0]['user_password'])
  end
end
