require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success

    assert_select "a" do
      assert_select "img"
    end
    assert_select "a[href=/users/sign_in]"
    assert_select "a[href=/users/sign_up]"
    assert_select "a[href=/parties]"
  end
end
