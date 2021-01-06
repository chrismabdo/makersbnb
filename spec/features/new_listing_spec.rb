# frozen_string_literal: true

feature 'user can add a new listing' do
  scenario 'add new listing' do
    signing_up_user_1

    visit('/')
    fill_in 'login_email', with: 'aj@example.com'
    fill_in 'login_password', with: 'password'
    click_button 'Log In'

    add_listing_1

    expect(page).to have_content 'Castle'
  end
end
