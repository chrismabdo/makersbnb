feature 'check username and email cannot be duplicated' do
    scenario 'checks against database' do
        visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
    click_button 'Take me home, country roads!'

    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content "There's a doppleganger somewhere..."
        
    end
end