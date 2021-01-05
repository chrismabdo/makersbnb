require 'user'
require 'spec_spec_spec'

describe User do
    
    it 'holds the information added upon sign up' do
        user = User.create("maker101", "password", "maker@example.com")

        expect(user.username).to eq "maker101"
        expect(user.password).to eq "password"
        expect(user.email).to eq "maker@example.com"
        expect(user.id).to eq "1"

    end

    it 'checks passsword is correct' do
        user = User.create("maker101", "password", "maker@example.com")
    
        expect(user.check_password("password")).to eq true 
        expect(user.check_password("2Dogs")).to eq false
    end 
end