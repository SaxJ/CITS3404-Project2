require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get sign_in" do
    get :sign_in
    assert_response :failure
  end

  test "should get sign_out" do
    get :sign_out
    assert_response :success
  end

end
