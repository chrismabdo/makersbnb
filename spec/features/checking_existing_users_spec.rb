feature 'check username and email cannot be duplicated' do
    scenario 'checks against database' do
       signing_up_user_1

    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content "There's a doppleganger somewhere..."

    end
end
