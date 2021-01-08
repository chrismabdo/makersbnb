def signing_up_user_1
    visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
end

def signing_up_user_2
    visit('/')
    fill_in 'username', with: 'Kiki'
    fill_in 'email', with: 'kiki@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
end

def signing_up_and_stay_on_page
    visit('/')
    fill_in 'username', with: 'AJ'
    fill_in 'email', with: 'aj@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign Up'
end

def log_in_user_1
    visit('/')
    fill_in 'login_email', with: 'aj@example.com'
    fill_in 'login_password', with: 'password'
    click_button 'Log In'
end

def log_in_user_2
    visit('/')
    fill_in 'login_email', with: 'kiki@example.com'
    fill_in 'login_password', with: 'password'
    click_button 'Log In'
end
