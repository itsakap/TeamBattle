# sign_in_spec.rb
require 'spec_helper'

feature 'signing in and out' do
  let!(:user){ FactoryGirl.create(:user) }
  before do
    visit '/'
    click_link 'Sign in'
  end

  scenario 'successfully sign in and out' do
    fill_in "Username", with: user.name
    fill_in "Password", with: user.password

    click_button "Sign in"
    expect(page).to have_content("Successfully signed in. Thanks.")

    click_link 'Sign out'
    expect(page).to have_content("Successfully signed out. See you soon!")
  end
end