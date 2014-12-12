require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "sign_in button" do
    visit "/users/sign_in"
    click_on "Вход"
    assert_equal "/users/sign_in", current_path
  end

  test "sign_up button" do
    visit "/users/sign_in"
    click_on "Зарегистрироваться"
    assert_equal "/users/sign_up", current_path
  end

  test "login" do
    visit "/users/sign_in"
    fill_in "Email", with: "lol@lol.lol"
    fill_in "Password", with: "lolkalolka"
    click_on "Log in"
    assert_equal "/", current_path
    click_on "Выйти"
    assert_equal "/", current_path
  end

  test "login wrong password" do
    visit "/users/sign_in"
    fill_in "Email", with: "lol@lol.lol"
    fill_in "Password", with: "lolkalolkaa"
    click_on "Log in"
    assert_equal "/users/sign_in", current_path
  end

  test "login wrong email right password" do
    visit "/users/sign_in"
    fill_in "Email", with: "lol@lol.lola"
    fill_in "Password", with: "lolkalolka"
    click_on "Log in"
    assert_equal "/users/sign_in", current_path
  end

  test "login wrong email wrong password" do
    visit "/users/sign_in"
    fill_in "Email", with: "lol@lol.lola"
    fill_in "Password", with: "lolkalolkaa"
    click_on "Log in"
    assert_equal "/users/sign_in", current_path
  end
end
