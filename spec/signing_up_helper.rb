def signing_up_user_1
    visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
    click_button 'Take me home, country roads!'
end

def signing_up_user_2
    visit('/')
    fill_in 'username', with: 'Kiki'
    fill_in 'email', with: 'kiki@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
    click_button 'Take me home, country roads!'
end
