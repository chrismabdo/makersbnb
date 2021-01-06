require 'adding_listing_helper.rb'

feature 'Making requests' do
    scenario 'User can make a request next to each listing' do
        signing_up_user_1
        signing_up_user_2
        log_in
        add_listing_1

        expect(page).to have_button 'Request Listing'
    end

    scenario 'request button relates to certain listing' do
      signing_up_user_1
      signing_up_user_2
      log_in
      add_listing_1
      add_listing_2
      choose('1')
      fill_in 'check_in', with: '2021-03-11'
      fill_in 'check_out', with: '2021-03-20'
      click_button 'Request Listing'
      expect(page).to have_content "Thank you for your request."
    end

    scenario 'has available dates on listings' do
        signing_up_user_1
        signing_up_user_2
        log_in
        add_listing_1
        add_listing_2
        choose('1')
        expect(page).to have_content "Check In"
        expect(page).to have_content "Check Out"
    end

    
end
