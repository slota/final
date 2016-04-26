class UserMarksAsReadTest < ActiveSupport::TestCase
  test "user can not edit links with bad url" do
    Link.create(url: "http://turing.io/", title: "title")
    create_user_and_log_in

    within("#title") do
      assert page.has_content?("Mark as read")
      click_on("Mark as read")
    end

    assert_current_path("/links")
    assert page.has_content?("Welcome John.Slota@gmail.com")
    assert page.has_content?("http://turing.io/")
    assert page.has_content?("title")

    assert_current_path("/links")
    assert page.has_content?("Mark as unread")
  end
end
