require 'signing_up_helper.rb'

feature 'Making requests' do
    scenario 'User can make a request next to each listing' do
        signing_up_user_1
        signing_up_user_2
        visit '/'
        click_button 'View Listings'
        expect(page).to have_content 'Request Listing'
    end
end