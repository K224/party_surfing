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
end
