require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @list = lists(:one)
    @workspace = workspaces(:one)
    @user = users(:one)
    @request.env['HTTP_REFERER'] = lists_path
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "shouldn't get new" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "shouldn't create list" do
    assert_no_difference('List.count') do
      post :create, list: { description: @list.description, name: @list.name }
    end

    assert_redirected_to new_user_session_path
  end

  test "shouldn't show list" do
    get :show, id: @list
    assert_redirected_to new_user_session_path
  end

  test "shouldn't get edit" do
    get :edit, id: @list
    assert_redirected_to new_user_session_path
  end

  test "should updaten't list" do
    patch :update, id: @list, list: { description: @list.description, name: @list.name }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't destroy list" do
    assert_no_difference('List.count') do
      delete :destroy, id: @list
    end
    assert_redirected_to new_user_session_path
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  test "should get new" do
    sign_in @user
    get :new , workspace_id: @workspace
    assert_response :success
  end

  test "shouldn't create list, no permission" do
    sign_in @user
    assert_no_difference('List.count') do
      post :create, list: { description: @list.description, name: @list.name }, workspace_id: workspaces(:two)
    end
    assert_redirected_to lists_path
  end

  test "shouldn't create list, invalid name" do
    sign_in @user
    assert_no_difference('List.count') do
      post :create, list: { description: "hello", name: "" }, workspace_id: @workspace
    end
  end

  test "should create list" do
    sign_in @user
    assert_difference('List.count') do
      post :create, list: { description: @list.description, name: @list.name }, workspace_id: @workspace
    end
    assert_redirected_to @workspace
  end

  test "should show list" do
    sign_in @user
    get :show, id: @list
    assert_response :success
  end

  test "shouldn't get edit,  no permission" do
    sign_in @user
    get :edit, id: lists(:two), workspace_id: workspaces(:two)
    assert_redirected_to lists_path
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @list, workspace_id: @workspace
    assert_response :success
  end

  test "should update list" do
    sign_in @user
    patch :update, id: @list, list: { description: "new description", name: "new name" }
    assert_redirected_to @list
    assert_equal("new name", List.find(@list.id).name)
    assert_equal( "new description", List.find(@list.id).description)
  end

  test "shouldn't update list, no permission" do
    sign_in @user
    patch :update, id: lists(:two), list: { description: "new description", name: "new name" }
    assert_redirected_to lists_path
  end

  test "shouldn't update list, invalid name" do
    sign_in @user
    patch :update, id: @list, list: { description: "valid", name: "" }
    assert_not_equal("", List.find(@list.id).name)
    assert_not_equal( "valid", List.find(@list.id).description)
  end

  test "should destroy list" do
    sign_in @user
    assert_difference('List.count', -1) do
      delete :destroy, id: @list
    end
    assert_redirected_to lists_path
  end

  test "shouldn't destroy list, no permission" do
    sign_in @user
    assert_no_difference('List.count') do
      delete :destroy, id: lists(:two)
    end
    assert_redirected_to lists_path
  end

end
