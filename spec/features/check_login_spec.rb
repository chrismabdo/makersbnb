feature 'checks login details are correct/exist' do
    scenario 'try to log in with correct details' do
        visit('/')
        fill_in 'username', with: 'AJ'
        fill_in 'email', with: 'aj@example.com'
        fill_in 'password', with: 'password'
        click_button 'Sign Up'

        visit('/login')
        fill_in 'email', with: 'aj@example.com'
        fill_in 'password', with: 'password'
        click_button 'Log In'

        expect(page).to have_content 'Welcome Aj'
        
    end

    scenario 'try to login with incorrect details' do
        visit('/')
        fill_in 'username', with: 'AJ'
        fill_in 'email', with: 'aj@example.com'
        fill_in 'password', with: 'password'
        click_button 'Sign Up'

        visit('/login')
        fill_in 'email', with: 'aj@example.com'
        fill_in 'password', with: '2dogs'
        click_button 'Log In'

        expect(page).to have_content "Sorry, we don't recognise your email or password"
        
    end
end