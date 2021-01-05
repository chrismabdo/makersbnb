feature 'view list of all spaces' do
    scenario 'can see all the spaces avaliable' do
    connection = PG.connect(dbname: 'makersbnb_test')
    # connection.exec("INSERT INTO users (username, user_email, user_password) VALUES ('Kiki', 'kiki@massivecastle.com', 'castle castle');")
    connection.exec("INSERT INTO spaces (name, description, price) VALUES ('Cave', 'large cave in Devon', '£5.00');")
    visit '/listings'

    expect(page).to have_content "Cave"
    expect(page).to have_content "large cave in Devon"
    expect(page).to have_content "£5.00"
  end
end
