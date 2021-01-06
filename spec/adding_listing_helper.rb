def add_listing_1
  visit '/listings'
  click_button 'Add New Listing'
  fill_in 'name', with: 'Castle'
  fill_in 'description', with: 'modest castle on hill'
  fill_in 'price', with: '£50.00'
  click_button 'Create New Listing'
end

def add_listing_2
  visit '/listings'
  click_button 'Add New Listing'
  fill_in 'name', with: 'Cave'
  fill_in 'description', with: 'Dark, damp, and horrible cave'
  fill_in 'price', with: '£5.00'
  click_button 'Create New Listing'
end
