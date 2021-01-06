# frozen_string_literal: true

feature 'user can add a new listing' do
  scenario 'add new listing' do
    visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'

    visit('/')
    fill_in 'login_email', with: 'aj@example.com'
    fill_in 'login_password', with: 'password'
    click_button 'Log In'

    visit '/listings'
    click_button 'Add New Listing'

    within('form') do
      fill_in 'name', with: 'Castle'
      fill_in 'description', with: 'modest castle on hill'
      fill_in 'price', with: '£50.00'
    end
    click_button 'Create New Listing'

    expect(page).to have_content 'Castle'
  end
end
