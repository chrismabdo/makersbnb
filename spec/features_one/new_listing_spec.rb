feature 'user can add a new listing' do
  scenario 'add new listing' do

    visit '/add-listing'

    within('form') do
      fill_in 'name', with: 'Castle'
      fill_in 'description', with: 'modest castle on hill'
      fill_in 'price', with: '£50.00'
    end
    click_button 'Create New Listing'

    expect(page).to have_content 'Castle'
  end
end
