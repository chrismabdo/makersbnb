feature 'has a page that can manage requests received and requested' do
    scenario 'can see requested request' do
        signing_up_user_1
        signing_up_user_2
        log_in_user_1
        add_listing_1
        add_listing_2
        click_button 'Log Out'
        log_in_user_2
        click_button 'View Listings'
        choose('1')
        click_button 'Request Listing'
        visit '/listings'
        click_button 'Log Out'
        log_in_user_1
        visit '/listings'
        click_button 'Manage Bookings'
        expect(page).to have_content 'Kiki has requested Castle'
        expect(page).to have_button 'Confirm booking'
        expect(page).to have_button 'Reject booking'
    end
end