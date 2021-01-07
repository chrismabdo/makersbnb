# frozen_string_literal: true

require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'
require './lib/space.rb'

class Request
  attr_reader :request_id, :space_id, :guest_id, :check_in, :check_out, :confirmed

  def initialize(request_id:, space_id:, guest_id:, check_in:, check_out:, confirmed:)
    @request_id = request_id
    @space_id = space_id
    @guest_id = guest_id
    @check_in = check_in
    @check_out = check_out
    @confirmed = confirmed
  end

  def self.create(space_id:, guest_id:, check_in:, check_out:)
    request = DatabaseConnection.query("INSERT INTO requests (space_id, guest_id, check_in, check_out) VALUES ('#{space_id}', '#{guest_id}', '#{check_in}', '#{check_out}') RETURNING request_id, space_id, guest_id, check_in, check_out, confirmed;")
    Request.new(request_id: request[0]['request_id'], space_id: request[0]['space_id'], guest_id: request[0]['guest_id'], check_in: request[0]['check_in'], check_out: request[0]['check_out'], confirmed: request[0]['confirmed'])
  end

  def self.show_sent_requests(user_id:)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE guest_id=#{user_id};")
    result.map do |request|
        Request.new(request_id: request['request_id'], space_id: request['space_id'], guest_id: request['guest_id'], check_in: request['check_in'], check_out: request['check_out'], confirmed: request['confirmed'])
    end
  end

  def self.find_properties(user_id:)
    result = DatabaseConnection.query("SELECT space_id FROM spaces WHERE user_id='#{user_id}';")
    result.map do |property|
      property['space_id']
    end
  end


  def self.show_recieved_requests(user_id:)
    properties = Request.find_properties(user_id: user_id)
    properties.map do |property|
      result = DatabaseConnection.query("SELECT * FROM requests WHERE space_id=#{property};")
      Request.new(request_id: result[0]['request_id'], space_id: result[0]['space_id'], guest_id: result[0]['guest_id'], check_in: result[0]['check_in'], check_out: result[0]['check_out'], confirmed: result[0]['confirmed'])
    end
  end
end
