# signing_up_spec.rb
require 'spec_helper'
feature "Signing Up" do
  before do
    visit '/'
    click_link 'Sign up'
  end

  scenario 'successfully sign up' do
    fill_in "Email", with: "adam@aol.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end
end
