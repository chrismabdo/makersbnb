# frozen_string_literal: true

feature 'user can add a new listing' do
  scenario 'add new listing' do
    visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
    click_button 'Take me home, country roads!'
    click_button 'View Listings'
    click_button 'Add New Listing'

    fill_in 'name', with: 'Castle'
    fill_in 'description', with: 'modest castle on hill'
    fill_in 'price', with: '£50.00'
    fill_in 'user_id', with: '1'
    click_button 'Create New Listing'

    expect(page).to have_content 'Castle'
  end
end
