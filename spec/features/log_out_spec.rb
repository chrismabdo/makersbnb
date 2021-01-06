feature 'checks log out clears details' do
    scenario 'try to log out' do
        signing_up_user_1

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
