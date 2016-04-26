
require 'test_helper'
require 'pry'

class UserVisitsLinkTest < ActiveSupport::TestCase
  test "user visits link page, uses incorrect url" do
    create_user
    visit("/")
    click_link("Log in")

    fill_in('Email', :with => "John.Slota@gmail.com")
    fill_in('Password', :with => "123")

    click_on("Log in")

    assert_current_path("/links")
    assert page.has_content?("Welcome John.Slota@gmail.com")
    assert page.has_content?("Url")
    assert page.has_content?("Title")

    fill_in('Url', :with => "base")
    fill_in('Title', :with => "title")

    click_on("Save Link")

    assert page.has_content?("URL is not valid.")
  end
end
