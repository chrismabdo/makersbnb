# frozen_string_literal: true

require 'space'
require 'user'

describe Space do
  describe '.show_listings' do
    it 'responds to the method .show_listings' do
      expect(Space).to respond_to :show_listings
    end
  end

  describe '.new_listing' do
    it 'adds a new listing to spaces' do
      User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
      Space.new_listing('Cave', 'small cave', '£2.00', '1')
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec('SELECT * FROM spaces;')

      expect(result[0]['name']).to eq 'Cave'
      expect(result[0]['description']).to eq 'small cave'
      expect(result[0]['price']).to eq '£2.00'
      expect(result[0]['user_id']).to eq '1'
    end
  end

  describe '.request' do
    it 'responds to request class method' do
      expect(Space).to respond_to :request
    end

    it 'records details of a users request' do
      User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
      User.create(username: 'Chris', email: 'chris@example.com', password: 'password')
      Space.new_listing('Cave', 'small cave', '£2.00', '1')
      Space.request('1','2')
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec('SELECT * FROM requests;')

      expect(result[0]['space_id']).to eq '1'
      expect(result[0]['guest_id']).to eq '2'
    end
  end
end
