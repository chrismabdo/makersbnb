# frozen_string_literal: true

feature 'has a sign up page' do
  scenario 'able to enter details to sign up' do
    visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
    expect(page).to have_content 'Thanks for signing up to MakersBnB'
  end
end
