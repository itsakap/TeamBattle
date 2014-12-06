# signing_up_spec.rb
require 'spec_helper'
feature "Signing Up" do
  before do
    visit '/'
    click_link 'Sign up'
    fill_in "Name", with: "Adam"
    fill_in "Email", with: "adam@aol.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
  end

  scenario 'successfully sign up' do
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario 'x+y+z exceeds stats_sum_maximum' do
    fill_in "x", with: User.stats_sum_maximum+1
    click_button "Sign up"
    expect(page).to have_content("Player could not be created.")
  end

  scenario 'x, y, z all must be non-negative' do
    fill_in "x", with: -1
    click_button "Sign up"
    expect(page).to have_content("Player could not be created.")
  end


end
