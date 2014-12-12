require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "sign_in button" do
    visit "/users/sign_up"
    click_on "Вход"
    assert_equal "/users/sign_in", current_path
  end

  test "sign_up button" do
    visit "/users/sign_up"
    click_on "Зарегистрироваться"
    assert_equal "/users/sign_up", current_path
  end
  
  test "signup partner links" do
    visit "/users/sign_up"
    assert has_link? "Sign in with Facebook"
    assert has_link? "Sign in with Vkontakte"
  end

  test "signup without all" do
    visit "/users/sign_up"
    click_on "Sign up"
    assert_equal "/users", current_path
    assert has_content? "3 errors prohibited this user from being saved:"
    assert has_content? "Profile birthday is incorrect"
    assert has_content? "Email can't be blank"
    assert has_content? "Password can't be blank"
  end
end
