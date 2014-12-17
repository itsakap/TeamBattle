# capybara_helpers.rb

module CapybaraHelpers
  def assert_no_link_for(text)
    expect(page).to_not(have_css("a", :text => text),
      "Expected not to see the #{text.inspect} link, but did.")
  end
  def assert_link_for(text)
    expect(page).to(have_css("a", :text => text),
      "Expected to see the #{text.inspect} link, but did not.")
  end
  def assert_no_button_for(text)
    expect(page).to_not(have_css("button", :text => text),
      "Expected not to see the #{text.inspect} button, but did.")
  end
  def assert_button_for(text)
    expect(page).to(have_css("button", :text => text),
      "Expected to see the #{text.inspect} button, but did not.")
  end
end

RSpec.configure do |c|
  c.include CapybaraHelpers, :type => :feature
end