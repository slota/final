
require 'test_helper'
require 'pry'

class UserVisitsLinkTest < ActiveSupport::TestCase
  test "user visits link page, uses incorrect url" do
    create_user_and_log_in


    fill_in('Url', :with => "base")
    fill_in('Title', :with => "title")

    click_on("Save Link")

    assert page.has_content?("URL is not valid.")
  end

  test "user visits link page, correct url" do
    create_user_and_log_in

    fill_in('Url', :with => "http://today.turing.io/outlines/2016-04-18/")
    fill_in('Title', :with => "title")

    click_on("Save Link")

    assert page.has_content?("Successfully saved link.")
    assert page.has_content?("title")
    assert page.has_content?("http://today.turing.io/outlines/2016-04-18/")
  end
end
