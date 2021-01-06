# frozen_string_literal: true

feature 'view list of all spaces' do
  scenario 'can see all the spaces avaliable' do
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

    fill_in 'name', with: 'Cave'
    fill_in 'description', with: 'large cave in Devon'
    fill_in 'price', with: '£50.00'
    click_button 'Create New Listing'

    visit '/listings'

    expect(page).to have_content 'Cave'
    expect(page).to have_content 'large cave in Devon'
    expect(page).to have_content '£50.00'
  end
end
