#encoding: utf-8

require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "Check header after login" do
    puts "
      5. Изменение шапки сервиса на главном экране после аутентификации.
        Проверяемое тест требование:
          1.1.1.2
        Шаги:
          1. Зайти на сайт(http://test-party.herokuapp.com/)
          2. Нажать на кнопку «Вход»
          3. Войти под учетной записью пользователя (логин – lol@lol.lol,пароль – lalkalalka)
        Ожидаемый результат:
          1. После нажатия на кнопку «Вход» осуществляется переход на страницу входа.
          2. После входа под соответствующей учетной записью осуществляется переход на главную страницу, где вместо кнопок «Вход» и «Зарегистрироваться» на странице расположены кнопки «Профиль» и «Выйти»."
    visit "/"
    click_on "Вход"
    fill_in "Email", with: "lol@lol.lol"
    fill_in "Password", with: "lolkalolka"
    click_on "Log in"
    assert has_link? "Профиль"
    assert has_link? "Выйти"
    click_on "Выйти"
  end
end
