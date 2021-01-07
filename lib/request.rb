# frozen_string_literal: true

require_relative '../database_connection_setup.rb'
require './lib/database_connection.rb'

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

  #   def self.show_requests(user_id:)
  #     result = DatabaseConnection.query("SELECT * FROM requests WHERE user_id=#{user_id};")
  #     result.map do |requests|
  #         requests =
  #   end

  def check_availability(space_id:, checked_date:)
    dates_query = DatabaseConnection.query("SELECT check_in, check_out FROM requests WHERE space_id=#{space_id};")
    result = dates_query.map do |range|
      if checked_date.between?((range['check_in']),(range['check_out'])) 
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
end
