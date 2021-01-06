feature 'view list of all spaces' do
    scenario 'can see all the spaces avaliable' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO users (username, user_email, user_password) VALUES ('Kiki', 'kiki@massivecastle.com', 'castle castle');")
    connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Cave', 'large cave in Devon', '£5.00');")
    
    visit('/')
        fill_in 'username', with: 'AJ'
        fill_in 'email', with: 'aj@example.com'
        fill_in 'password', with: 'password'
        click_button 'Sign Up'

        visit('/')
        fill_in 'login_email', with: 'aj@example.com'
        fill_in 'login_password', with: 'password'
        click_button 'Log In'
    
    visit '/listings'

    expect(page).to have_content "Cave"
    expect(page).to have_content "large cave in Devon"
    expect(page).to have_content "£5.00"
  end
end
