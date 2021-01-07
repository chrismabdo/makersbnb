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

  it 'returns the sent requests depending on the user' do
    User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
    User.create(username: 'Chris', email: 'chris@example.com', password: 'password')
    Space.new_listing('Cave', 'small cave', '£2.00', '1')
    Space.new_listing('Big Cave', 'big cave', '£4.00', '2')
    Request.create(space_id: '1', guest_id: '2', check_in: '2021-03-01', check_out: '2021-03-07')
    Request.create(space_id: '2', guest_id: '2', check_in: '2021-03-10', check_out: '2021-03-17')
    Request.create(space_id: '1', guest_id: '1', check_in: '2021-03-21', check_out: '2021-03-27')

    requests = Request.show_sent_requests(user_id: 2)

    expect(requests.length).to eq 2
    expect(requests[0].check_in).to eq '2021-03-01'
    expect(requests[1].check_out).to eq '2021-03-17'
  end

  it 'finds all properties with same owner' do
    User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
    Space.new_listing('Cave', 'small cave', '£2.00', '1')
    Space.new_listing('Castle', 'small castle', '£20.00', '1')

    find_properties = Request.find_properties(user_id: 1)

    expect(find_properties).to eq ["1", "2"]
  end

  it 'returns the recieved requests depending on the user' do
    User.create(username: 'AJ', email: 'aj@example.com', password: 'password')
    User.create(username: 'Chris', email: 'chris@example.com', password: 'password')
    Space.new_listing('Cave', 'small cave', '£2.00', '1')
    Space.new_listing('Big Cave', 'big cave', '£4.00', '2')
    Space.new_listing('Castle', 'small castle', '£20.00', '1')
    Space.new_listing('Big Castle', 'big castle', '£40.00', '2')
    Request.create(space_id: '1', guest_id: '2', check_in: '2021-03-01', check_out: '2021-03-07')
    Request.create(space_id: '2', guest_id: '2', check_in: '2021-03-10', check_out: '2021-03-17')
    Request.create(space_id: '3', guest_id: '1', check_in: '2021-03-21', check_out: '2021-03-27')

    requests = Request.show_recieved_requests(user_id: 1)

    expect(requests.length).to eq 2
    expect(requests[0].check_in).to eq '2021-03-01'
    expect(requests[1].check_out).to eq '2021-03-27'
  end
end
