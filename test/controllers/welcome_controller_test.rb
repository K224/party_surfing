#encoding: utf-8

require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  def setup
    visit "/"
    if has_link? "Выйти"
      click_on "Выйти"
    end
  end

  test "sign_in button" do
    puts "
      2. Кнопка «Вход» на главном экране.
        Проверяемое тест требование:
          1.1.1.6
        Шаги:
          1. Зайти на сайт(http://test-party.herokuapp.com/)
          2. Нажать на кнопку «Вход»
        Ожидаемый результат:
          Осуществляется переход на страницу входа."
    visit "/"
    assert has_link? "Вход"
    click_on "Вход"
    assert_equal "/users/sign_in", current_path
  end

  test "sign_up button" do
    puts "
      3. Кнопка «Зарегистрироваться» на главном экране.
        Проверяемое тест требование:
          1.1.1.5
        Шаги:
          1. Зайти на сайт(http://test-party.herokuapp.com/)
          2. Нажать на кнопку «Зарегистрироваться»
        Ожидаемый результат:
          Осуществляется переход на страницу регистрации пользователей."
    visit "/"
    click_on "Зарегистрироваться"
    assert_equal "/users/sign_up", current_path
  end

  test "let's party button" do
    puts "
      4. Кнопка «Let’sParty» на главном экране.
        Проверяемое тест требование:
          1.1.1.4
        Шаги:
          1. Зайти на сайт(http://test-party.herokuapp.com/)
          2. Нажать на кнопку «Let’sParty»
        Ожидаемый результат:
          Осуществляется переход на страницупоиска мероприятий."
    visit "/"
    click_on "Let's Party"
    assert_equal "/parties", current_path
  end
end
