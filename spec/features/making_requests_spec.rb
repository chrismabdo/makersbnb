require 'signing_up_helper.rb'
require 'adding_listing_helper.rb'

feature 'Making requests' do
    scenario 'User can make a request next to each listing' do
        signing_up_user_1
        signing_up_user_2
        add_listing_1

        expect(page).to have_button 'Request Listing'
    end

    scenario 'request button relates to certain listing' do
      signing_up_user_1
      signing_up_user_2
      add_listing_1
      add_listing_2
      fill_in 'guest_id', with: '1'
      choose('1')
      click_button 'Request Listing'

      expect(page).to have_content "Thank you for your request."
    end
end
