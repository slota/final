require 'test_helper'
require 'pry'

class UserVisitsLinkPageTest < ActiveSupport::TestCase
  test "user can edit links" do
    create_user_and_log_in

    assert_current_path("/links")
    assert page.has_content?("Welcome john.slota@gmail.com")
    assert page.has_content?("Url")
    assert page.has_content?("Title")

    within("#title") do
      assert page.has_content?("edit")
      click_on("edit")
    end

    assert current_path, "/links/1/edit"
    page.has_field?('Url', :with => 'url_one')
    page.has_field?('Title', :with => 'title')

    fill_in("Url", :with => "https://github.com/")
    fill_in("Title", :with => "john")

    click_on("Save changes")

    assert current_path, "/links"
    assert page.has_content?("john")
    assert page.has_content?("https://github.com/")
  end

  test "user can not edit links with bad url" do
    create_user_and_log_in

    assert_current_path("/links")
    assert page.has_content?("Welcome john.slota@gmail.com")
    assert page.has_content?("Url")
    assert page.has_content?("Title")

    within("#title") do
      assert page.has_content?("edit")
      click_on("edit")
    end

    assert current_path, "/links/1/edit"
    page.has_field?('Url', :with => 'url_one')
    page.has_field?('Title', :with => 'title')

    fill_in("Url", :with => "//github.com/")
    fill_in("Title", :with => "john")

    click_on("Save changes")

    assert current_path, "/links/1/edit"
    assert page.has_content?("Save unsuccessful.")

  end
end
