# frozen_string_literal: true

require 'request'

describe Request do
  it 'creates a request in the database' do
    User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
    User.create(username: 'Chris', email: 'chris@example.com', password: 'password')
    Space.new_listing('Cave', 'small cave', '£2.00', '1')
    Space.new_listing('Big Cave', 'big cave', '£4.00', '2')
    Request.create(space_id: '1', guest_id: '2', check_in: '2021-03-01', check_out: '2021-03-07')
    Request.create(space_id: '2', guest_id: '1', check_in: '2021-03-07', check_out: '2021-03-10')
    connection = PG.connect(dbname: 'makersbnb_test')
    result = connection.exec('SELECT * FROM requests;')

    expect(result[0]['space_id']).to eq '1'
    expect(result[0]['guest_id']).to eq '2'
    expect(result[0]['check_in']).to eq '2021-03-01'
    expect(result[0]['check_out']).to eq '2021-03-07'
    expect(result[1]['space_id']).to eq '2'
    expect(result[1]['guest_id']).to eq '1'
    expect(result[1]['check_in']).to eq '2021-03-07'
    expect(result[1]['check_out']).to eq '2021-03-10'
  end

  it 'initializes a new instance of request on create' do
    User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
    User.create(username: 'Chris', email: 'chris@example.com', password: 'password')
    Space.new_listing('Cave', 'small cave', '£2.00', '1')
    Space.new_listing('Big Cave', 'big cave', '£4.00', '2')
    request = Request.create(space_id: '1', guest_id: '2', check_in: '2021-03-01', check_out: '2021-03-07')

    expect(request.space_id).to eq '1'
    expect(request.guest_id).to eq '2'
    expect(request.check_in).to eq '2021-03-01'
    expect(request.check_out).to eq '2021-03-07'
    expect(request.confirmed).to be_nil
  end
end
