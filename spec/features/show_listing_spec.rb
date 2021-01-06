feature 'view list of all spaces' do
  scenario 'can see all the spaces avaliable' do
    visit('/')
    signing_up_user_1

    visit('/')
    fill_in 'login_email', with: 'aj@example.com'
    fill_in 'login_password', with: 'password'
    click_button 'Log In'

    add_listing_2

    visit '/listings'
    expect(page).to have_content 'Cave'
    expect(page).to have_content 'Dark, damp, and horrible cave'
    expect(page).to have_content '£5.00'
  end
end
