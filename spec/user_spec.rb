require 'user'
require_relative '../clear_tables'

describe User do
    
    it 'holds the information added upon sign up' do
        user = User.create("maker101", "password", "maker@example.com")

        expect(user.username).to eq "maker101"
        expect(user.password).to eq "password"
        expect(user.email).to eq "maker@example.com"
        expect(user.id).to eq "1"

    end
end