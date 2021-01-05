# frozen_string_literal: true

require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'

class User
  attr_reader :id, :username, :email, :password, :user_check

  def initialize(id, username, password, email)
    @id = id
    @username = username
    @email = email
    @password = password
  end

  def self.create(username, password, email)
    user = DatabaseConnection.query("INSERT INTO users (username, user_password, user_email) VALUES ('#{username.downcase}', '#{password}', '#{email.downcase}') RETURNING user_id, user_email, username, user_password;")
    User.new(user[0]['user_id'], user[0]['username'], user[0]['user_password'], user[0]['user_email'])
  end


  def self.copy_check(username, email)
    false unless user_check(username) == true || email_check(email) == true
  end

  def self.user_check(username)
    @user_check = DatabaseConnection.query("SELECT * FROM users WHERE username='#{username.downcase}';")
    check = @user_check.map do |name|
        true if name = username
    end
    check[0]
  end

  def self.email_check(email)
    @email_check = DatabaseConnection.query("SELECT * FROM users WHERE user_email='#{email.downcase}';")
    check = @email_check.map do |address|
        true if address = email
        end
    check[0]
  end
end
