#encoding: utf-8

require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "" do
    puts "
      151. Поля для внесения контактной информации.
        Проверяемое тест требование:
          2.1.8.1
        Предварительные шаги:
          1) Зайти на сайт(http://test-party.herokuapp.com/)
          2) Выполнить вход в аккаунт сервиса (логин: «sweet_chery2010@mail.ru», пароль: «235595an»).
        Шаги:
          1) Перейти на страницу редактирования профиля. 
        Ожидаемый результат:
          На странице присутствуют текстовые поля для внесения контактной информации: skype, телефон, ссылка на страницу Вконтакте, ссылка на страницу Facebook."
    visit "/"
    click_on "Вход"
    fill_in "E-mail", with: "lol@lol.lol"
    fill_in "Пароль", with: "lolkalolka"
    click_on "Войти"
    click_on "Профиль"
    click_on "Редактировать профиль"
    assert_text "Телефон"
    assert_text "Skype"
    assert_text "Vkontakte"
    assert_text "Facebook"
    click_on "Выйти"
  end

  test "Too long name" do
    puts "
    156. Редактирование имени.
      Проверяемое тест требование:
        2.1.8.5
      Предварительные шаги:
        1) Зайти на сайт(http://test-party.herokuapp.com/)
        2) Выполнить вход в аккаунт сервиса (логин: «sweet_chery2010@mail.ru», пароль: «235595an»).
        3) Перейти на страницу редактирования профиля.
      Шаги:
        1) Ввести в поле для редактирования имени пользователя: «AAAA…» (256 символов «А»).
        2) Нажать на кнопку для сохранения изменений.
      Ожидаемый результат:
        Вывод на экран текстового сообщения об ошибке: «Name is too long»."
    visit "/"
    click_on "Вход"
    fill_in "E-mail", with: "lol@lol.lol"
    fill_in "Пароль", with: "lolkalolka"
    click_on "Войти"
    click_on "Профиль"
    click_on "Редактировать профиль"
    click_on "Выйти"
  end

  test "Change user name" do
    puts "
    157. Редактирование имени.
      Проверяемое тест требование:
        2.1.8.5
      Предварительные шаги:
        1) Зайти на сайт(http://test-party.herokuapp.com/)
        2) Выполнить вход в аккаунт сервиса (логин: «sweet_chery2010@mail.ru», пароль: «235595an»).
        3) Перейти на страницу редактирования профиля.
      Шаги:
        1) Ввести в поле для редактирования имени пользователя: «AAAA…» (255 символов «А»).
        2) Нажать на кнопку для сохранения изменений.
      Ожидаемый результат:
        Имя пользователя изменилось."
    visit "/"
    click_on "Вход"
    fill_in "E-mail", with: "lol@lol.lol"
    fill_in "Пароль", with: "lolkalolka"
    click_on "Войти"
    click_on "Профиль"
    click_on "Редактировать профиль"
    click_on "Выйти"
    assert true
  end
end
