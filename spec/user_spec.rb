# frozen_string_literal: true

require 'user'
require 'spec_spec_spec'
require 'bcrypt'

describe User do
  it 'holds the information added upon sign up' do
    user = User.create('maker101', 'password', 'maker@example.com')
    result = DatabaseConnection.query("SELECT * FROM users WHERE user_email='maker@example.com';")
    encrypted_password = BCrypt::Password.new(result[0]['user_password'])

    expect(user.username).to eq 'Maker101'
    expect(user.password).to eq encrypted_password
    expect(user.email).to eq 'maker@example.com'
    expect(user.id).to eq '1'
  end

  it 'checks passsword is correct' do
    user = User.create('maker101', 'password', 'maker@example.com')

    expect(User.check_password('maker@example.com', 'password')).to eq true
    expect(User.check_password('maker@example.com', '2Dogs')).to eq false
  end
end
