# frozen_string_literal: true

feature 'has a sign up page' do
  scenario 'able to enter details to sign up' do
    signing_up_and_stay_on_page
    expect(page).to have_content 'Thanks for signing up to MakersBnB'
  end
end
