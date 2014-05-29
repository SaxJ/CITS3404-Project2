require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get sign_in" do
    get :sign_in
    assert_response :success
  end

  test "should get sign_out" do
    get :sign_out
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get loggedin instead of sign_in" do
    sign_in users(:one)
    get :sign_in
    assert_redirected_to loggedin_path
  end

  test "shoud get sign_in instead of loggedin" do
    get :signed_in
    assert_redirected_to login_path
  end

  test "should get loggedin instead of register" do
    sign_in users(:one)
    get :register
    assert_redirected_to loggedin_path
  end

end
