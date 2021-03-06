# frozen_string_literal: true

require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'
require './lib/space.rb'

class Request
  attr_reader :request_id, :space_id, :guest_id, :check_in, :check_out, :confirmed, :space_name, :guest_name

  def initialize(request_id:, space_id:, guest_id:, check_in:, check_out:, confirmed:)
    @request_id = request_id
    @space_id = space_id
    @guest_id = guest_id
    @check_in = check_in
    @check_out = check_out
    @confirmed = confirmed
    @space_name = Space.find(space_id: space_id).name
    @guest_name = Request.guest_name_find(guest_id: guest_id)
  end

  def self.create(space_id:, guest_id:, check_in:, check_out:, confirmed: false)
    request = DatabaseConnection.query("INSERT INTO requests (space_id, guest_id, check_in, check_out) VALUES ('#{space_id}', '#{guest_id}', '#{check_in}', '#{check_out}') RETURNING request_id, space_id, guest_id, check_in, check_out, confirmed;")
    Request.new(request_id: request[0]['request_id'], space_id: request[0]['space_id'], guest_id: request[0]['guest_id'], check_in: request[0]['check_in'], check_out: request[0]['check_out'], confirmed: request[0]['confirmed'])
  end

  def check_full_availability(space_id:, check_in:, check_out:)
    if (check_date_availability(space_id: space_id, checked_date: check_in) == true) && (check_date_availability(space_id: space_id, checked_date: check_out) == true)
     true
    else
      false
    end
  end

  def check_date_availability(space_id:, checked_date:)
    dates_query = DatabaseConnection.query("SELECT check_in, check_out FROM requests WHERE space_id='#{space_id}' AND confirmed=TRUE;")
    result = dates_query.map do |range|
      if checked_date.between?((range['check_in']),(range['check_out'])) == true
        false
      else
        true
      end
    end
    if result.include? false
      false
    else
      true
    end
  end

  def self.show_sent_requests(user_id:)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE guest_id=#{user_id};")
    result.map do |request|
      Request.new(request_id: request['request_id'], space_id: request['space_id'], guest_id: request['guest_id'], check_in: request['check_in'], check_out: request['check_out'], confirmed: request['confirmed'])
    end
  end

  def self.find_properties(user_id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE user_id='#{user_id}';")
    result.map do |property|
      property['space_id']
    end
  end

  def self.show_recieved_requests(user_id:)
    owned_spaces = Request.find_properties(user_id: user_id)
    owned_spaces.map do |space|
      result = DatabaseConnection.query("SELECT * FROM requests WHERE space_id=#{space};")
      result.map do |request|
        Request.new(request_id: request['request_id'], space_id: request['space_id'], guest_id: request['guest_id'], check_in: request['check_in'], check_out: request['check_out'], confirmed: request['confirmed'])
      end
    end
  end

  def self.guest_name_find(guest_id:)
    result = DatabaseConnection.query("SELECT username FROM users WHERE user_id='#{guest_id}';")
    result[0]['username'].capitalize
  end

  def self.confirm(request_id:)
    DatabaseConnection.query("UPDATE requests SET confirmed=TRUE WHERE request_id='#{request_id}';")
  end

  def self.reject(request_id:)
    DatabaseConnection.query("UPDATE requests SET confirmed=FALSE WHERE request_id='#{request_id}';")
  end

  def self.cancel(request_id:)
    DatabaseConnection.query("DELETE FROM requests WHERE request_id='#{request_id}';")
  end

end
