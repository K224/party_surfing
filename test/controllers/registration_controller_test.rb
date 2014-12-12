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

  test "signup without password" do
    visit "/users/sign_up"
    fill_in "Email", with: "hello@world.com"
    click_on "Sign up"
    assert_equal "/users", current_path
    assert has_content? "2 errors prohibited this user from being saved:"
    assert has_content? "Profile birthday is incorrect"
    assert has_content? "Password can't be blank"
  end

  test "signup without email" do
    visit "/users/sign_up"
    fill_in "Password", with: "hello"
    click_on "Sign up"
    assert_equal "/users", current_path
    assert has_content? "4 errors prohibited this user from being saved:"
    assert has_content? "Profile birthday is incorrect"
    assert has_content? "Email can't be blank"
    assert has_content? "Password confirmation doesn't match Password"
    assert has_content? "Password is too short (minimum is 8 characters)"
  end

  test "signup with short password" do
    visit "/users/sign_up"
    fill_in "Email", with: "hello@world.com"
    fill_in "Password", with: "hello"
    fill_in "Password confirmation", with: "hello"
    fill_in "Birthday", with: "01-01-1992"
    click_on "Sign up"
    assert_equal "/users", current_path
    assert has_content? "1 error prohibited this user from being saved:"
    assert has_content? "Password is too short (minimum is 8 characters)"
  end

  test "signup with wrong password confirmation" do
    visit "/users/sign_up"
    fill_in "Email", with: "hello@world.com"
    fill_in "Password", with: "helloworld"
    fill_in "Password confirmation", with: "helloworld123"
    fill_in "Birthday", with: "01-01-1992"
    click_on "Sign up"
    assert_equal "/users", current_path
    assert has_content? "1 error prohibited this user from being saved:"
    assert has_content? "Password confirmation doesn't match Password"
  end

  test "signup ok" do
    visit "/users/sign_up"
    fill_in "Email", with: "hello@world.com"
    fill_in "Password", with: "helloworld"
    fill_in "Password confirmation", with: "helloworld"
    fill_in "Birthday", with: "01-01-1992"
    click_on "Sign up"
    assert_equal "/", current_path
    assert has_link? "Выйти"
    assert has_link? "Профиль"
    click_on "Выйти"
    click_on "Вход"
    fill_in "Email", with: "hello@world.com"
    fill_in "Password", with: "helloworld"
    click_on "Log in"
    assert_equal "/", current_path
    assert has_link? "Выйти"
    assert has_link? "Профиль"
    click_on "Выйти"
  end

  test "signup user exists" do
    visit "/users/sign_up"
    fill_in "Email", with: "joker@world.com"
    fill_in "Password", with: "jokerworld"
    fill_in "Password confirmation", with: "jokerworld"
    fill_in "Birthday", with: "01-01-1992"
    click_on "Sign up"
    assert_equal "/", current_path
    assert has_link? "Выйти"
    assert has_link? "Профиль"
    click_on "Выйти"
    click_on "Вход"
    fill_in "Email", with: "joker@world.com"
    fill_in "Password", with: "jokerworld"
    click_on "Log in"
    assert_equal "/", current_path
    assert has_link? "Выйти"
    assert has_link? "Профиль"
    click_on "Выйти"
    visit "/users/sign_up"
    fill_in "Email", with: "joker@world.com"
    fill_in "Password", with: "jokerworld1"
    fill_in "Password confirmation", with: "jokerworld1"
    fill_in "Birthday", with: "01-01-1992"
    click_on "Sign up"
    assert_equal "/users", current_path
    assert has_content? "1 error prohibited this user from being saved:"
    assert has_content? "Email has already been taken"
  end
end
