#encoding: utf-8

require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  def setup
    visit "/"
    click_on "Вход"
    fill_in "Email", with: "lol@lol.lol"
    fill_in "Password", with: "lolkalolka"
    click_on "Log in"
  end

  def teardown
    visit "/"
    click_on "Выйти"
  end

  test "check links" do
    visit "/"
    click_on "Профиль"
    assert_not_equal "/", current_path
    assert has_link? "Редактировать профиль"
    assert has_link? "Создать мероприятие"
    assert has_link? "Start Surfing"
    # assert has_content? "Мои мероприятия"
    # assert has_content? "Не создавал"
    # assert has_content? "Принимал участие"
    # assert has_content? "Не участвовал"
  end
end
