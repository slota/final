ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include Capybara::DSL
  def create_user_and_log_in

    user = User.create(email: "john.slota@gmail.com", password: "123")
    Link.create(url: "http://turing.io/", title: "title", user_id: user.id )
    visit("/")
    click_link("Log in")

    fill_in('Email', :with => "john.slota@gmail.com")
    fill_in('Password', :with => "123")

    click_on("Log in")

    assert_current_path("/links")
    assert page.has_content?("Welcome john.slota@gmail.com")
    assert page.has_content?("Url")
    assert page.has_content?("Title")
  end
  # Add more helper methods to be used by all tests here...
end
