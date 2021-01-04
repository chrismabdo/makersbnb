feature 'view list of all spaces' do
    scenario 'can see all the spaces avaliable' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO users (username, user_email, user_password) VALUES ('Kiki', 'kiki@massivecastle.com', 'castle castle');")
    connection.exec("INSERT INTO spaces (name, description, price, user_id) VALUES ('Castle', 'modest castle on hill', '£50.00', '1');")
    visit '/listings'
    expect(page).to have_content "Castle"
    end
end