require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @request.env['HTTP_REFERER'] = users_path
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "shouldn't get new" do
    get :new
    assert_redirected_to new_user_session_path
  end


  test "shouldn't get new while signed in" do
    sign_in @user
    get :new
    assert_redirected_to loggedin_path
  end

  # should not be able to create user other than register
  test "should not create user while signed in" do
    sign_in @user
    assert_no_difference('User.count') do
      post :create, user: { name: @user.name }
    end
    assert_redirected_to loggedin_path
  end

  test "shouldn't create user" do
    post :create, user: { name: @user.name }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't show user" do
    get :show, id: @user
    assert_redirected_to new_user_session_path
  end

  test "should show user" do
    sign_in @user
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @user
    assert_response :success
  end

  test "shouldn't get edit" do
    get :edit, id: @user
    assert_redirected_to new_user_session_path
  end

  test "no permission to edit" do
    sign_in @user
    get :edit, id: users(:two)
    assert_redirected_to users_path
  end

  test "shouldn't update user" do
    patch :update, id: @user, user: { name: @user.name }
    assert_redirected_to new_user_session_path
  end

  test "should update user" do
    sign_in @user
    patch :update, id: @user, user: { name: "mary" }
    assert_redirected_to user_path(assigns(:user))
    assert_equal "mary", User.find(users(:one).id).name
  end

  test "shouldn't update user, invalid name" do
    sign_in @user
    patch :update, id: @user, user: { name: "d" }
    assert_not_equal "d", User.find(users(:one).id).name
  end

  test "no permission to update" do
    sign_in @user
    patch :update, id: users(:two)
    assert_redirected_to users_path
  end

  test "shouldn't destroy user" do
    delete :destroy, id: @user
    assert_redirected_to new_user_session_path
  end

  test "should destroy user" do
    sign_in @user
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path
  end

  test "no permission to destroy" do
    sign_in @user
    assert_no_difference('User.count') do
      delete :destroy, id: users(:two)
    end
    assert_redirected_to users_path
  end

end
