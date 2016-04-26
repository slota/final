require 'test_helper'
require 'pry'

class UserVisitsRootTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "unauthenticated user visits root" do
    visit('/')
    assert page.has_content?("Log In or Sign Up")
  end

  test "unauthenticated user clicks sign up" do
    visit("/")
    click_link("Sign Up")

    assert page.has_content?("Email")
    assert page.has_content?("Password")
    assert page.has_content?("Password confirmation")

    fill_in('Email', :with => "John.Slota@gmail.com")
    fill_in('Password', :with => "123")
    fill_in('Password confirmation', :with => "123")

    click_on("Save User")

    assert_current_path("/links")
    assert page.has_content?("Welcome John.Slota@gmail.com")
  end
end
