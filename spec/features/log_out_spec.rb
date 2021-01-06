feature 'checks log out clears details' do
    scenario 'try to log out' do
        visit('/')
        fill_in 'username', with: 'AJ'
        fill_in 'email', with: 'aj@example.com'
        fill_in 'password', with: 'password'
        click_button 'Sign Up'

        visit('/')
        fill_in 'login_email', with: 'aj@example.com'
        fill_in 'login_password', with: 'password'
        click_button 'Log In'

        visit('/listings')
        click_button 'Log Out'
        
        visit('/listings')
        expect(page).not_to have_content 'Aj'
    end
end
