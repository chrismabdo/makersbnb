feature 'checks login details are correct/exist' do
    scenario 'try to log in with correct details' do
        signing_up_user_1
        visit('/')
        fill_in 'login_email', with: 'aj@example.com'
        fill_in 'login_password', with: 'password'
        click_button 'Log In'

        expect(page).to have_content 'Welcome To The Booking Page, Aj'
    end

    scenario 'try to login with incorrect details' do
        signing_up_user_1
        visit('/')
        fill_in 'login_email', with: 'aj@example.com'
        fill_in 'login_password', with: '2dogs'
        click_button 'Log In'

        expect(page).to have_content "Sorry, we don't recognise your email or password"

    end
end
