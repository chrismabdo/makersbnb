require 'signing_up_helper.rb'

feature 'Making requests' do
    scenario 'User can make a request next to each listing' do
        signing_up_user_1
        signing_up_user_2
        visit '/listings'
        click_button 'Add New Listing'

        within('form') do
          fill_in 'name', with: 'Castle'
          fill_in 'description', with: 'modest castle on hill'
          fill_in 'price', with: '£50.00'
        end
        click_button 'Create New Listing'
    
        expect(page).to have_button 'Request Listing'
    end
end