# frozen_string_literal: true

def make_request_and_log_out
  visit '/listings'
  choose('1')
  fill_in 'check_in', with: '2021-03-01'
  fill_in 'check_out', with: '2021-03-20'
  click_button 'Request Listing'
  visit '/listings'
  click_button 'Log Out'
end
