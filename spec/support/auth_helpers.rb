# auth_helpers.rb
module AuthHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end
  def sign_in_as!(user)
    visit '/sign_in'
    fill_in "Username", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content("Successfully signed in. Thanks.")
  end
end
RSpec.configure do |c|
  c.include AuthHelpers, type: :feature
  c.include AuthHelpers, type: :controller
end
