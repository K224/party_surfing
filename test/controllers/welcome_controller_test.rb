require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "sign_in button" do
    visit "/"
    click_on "Вход"
    assert_equal "/users/sign_in", current_path
  end

  test "sign_up button" do
    visit "/"
    click_on "Зарегистрироваться"
    assert_equal "/users/sign_up", current_path
  end

  test "let's party button" do
    visit "/"
    click_on "Let's Party"
    assert_equal "/parties", current_path
  end
end
