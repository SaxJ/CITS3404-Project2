require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
    @user = users(:one)
    @workspace = workspaces(:one)
    @list = lists(:one)
    @request.env['HTTP_REFERER'] = lists_path
  end

  test "shouldn't get index" do
    get :index, list_id: @list
    assert_redirected_to new_user_session_path
  end

  test "shouldn't get index, no permission" do
    sign_in users(:two)
    get :index, list_id: @list
    assert_redirected_to workspaces_path
  end

  test "should get index" do
    sign_in @user
    get :index, list_id: @list
    assert_response :success
  end

  test "shouldn't get new" do
    get :new, list_id: @list
    assert_redirected_to new_user_session_path
  end

  test "shouldn't get new, no permission" do
    sign_in users(:two)
    get :new, list_id: @list
    assert_redirected_to workspaces_path
  end

  test "should get new" do
    sign_in @user
    get :new, list_id: @list
    assert_response :success
  end

  test "shouldn't create item" do
    post :create, list_id: @list, item: { content: @item.content, due: @item.due }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't create item, no permission" do
    sign_in users(:two)
    assert_no_difference('Item.count') do
      post :create, list_id: @list, item: { content: @item.content, due: @item.due }
    end
    assert_redirected_to workspaces_path
  end

  test "shouldn't create item, invalid content" do
    sign_in @user
    assert_no_difference('Item.count') do
      post :create, list_id: @list, item: { content: "", due: @item.due }
    end
  end

  test "should create item" do
    sign_in @user
    assert_difference('Item.count') do
      post :create, list_id: @list, item: { content: @item.content, due: @item.due }
    end

    assert_redirected_to @workspace
  end

  test "shouldn't show item" do
    get :show, list_id: @list, id: @item
    assert_redirected_to new_user_session_path
  end

  test "shouldn't show item, no permission" do
    sign_in users(:two)
    get :show, list_id: @list, id: @item
    assert_redirected_to workspaces_path
  end

  test "should show item" do
    sign_in @user
    get :show, list_id: @list, id: @item
    assert_response :success
  end

  test "shouldn't get edit" do
    get :edit, list_id: @list, id: @item
    assert_redirected_to new_user_session_path
  end

  test "shouldn't get edit, no permission" do
    sign_in users(:two)
    get :edit, list_id: @list, id: @item
    assert_redirected_to workspaces_path
  end

  test "should get edit" do
    sign_in @user
    get :edit, list_id: @list, id: @item
    assert_response :success
  end

  test "shouldn't update item" do
    patch :update, list_id: @list, id: @item, item: { content: @item.content, due: @item.due }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't update item, no permission" do
    sign_in users(:two)
    patch :update, list_id: @list, id: @item, item: { content: @item.content, due: @item.due }
    assert_redirected_to workspaces_path
  end

  test "shouldn't update item, invalid content" do
    sign_in @user
    patch :update, list_id: @list, id: @item, item: { content: "a", due: @item.due }
    assert_not_equal("a", Item.find(@item.id).content)
  end

  test "should update item" do
    sign_in @user
    patch :update, list_id: @list, id: @item, item: { content: "Hello", due: @item.due }
    assert_equal("Hello", Item.find(@item.id).content)
    assert_redirected_to @workspace
  end

  test "shouldn't destroy item" do
    assert_no_difference('Item.count') do
      delete :destroy, list_id: @list, id: @item
    end
    assert_redirected_to new_user_session_path
  end

  test "shouldn't destroy item, no permission" do
    sign_in users(:two)
    assert_no_difference('Item.count') do
      delete :destroy, list_id: @list, id: @item
    end
    assert_redirected_to workspaces_path
  end

  test "should destroy item" do
    sign_in @user
    assert_difference('Item.count', -1) do
      delete :destroy, list_id: @list, id: @item
    end
    assert_redirected_to @workspace
  end

  test "shouldn't add user" do
   #POST   /workspaces/:w_id/lists/:l_id/items/:id/addme(.:format)    items#addme
    post :addme, w_id: @workspace, l_id: @list, id: @item
    assert_redirected_to new_user_session_path
  end

  test "shouldn't add user, no permission" do
    sign_in @user
    post :addme, w_id: workspaces(:two), l_id: lists(:two), id: items(:two)
    assert_redirected_to workspaces_path
  end

  test "shouldn't add user, already existed" do
    sign_in @user
    post :addme, w_id: @workspace, l_id: @list, id: @item
    assert_redirected_to @workspace
  end

  test "should add user" do
    sign_in @user
    assert_difference('Item.count') do
      post :create, list_id: @list, item: { content: @item.content, due: @item.due }
    end
    assert_difference('assigns(:item).users.count') do
      post :addme, w_id: @workspace, l_id: @list, id: assigns(:item)
    end
    assert_redirected_to @workspace
  end

  test "shouldn't remove user" do
# DELETE /workspaces/:w_id/lists/:l_id/items/:id/removeme(.:format) items#removeme
#  POST   /workspaces/:w_id/items/:id/toggledone(.:format)           items#toggledone
    delete :removeme, w_id: @workspace, l_id: @list, id: @item
    assert_redirected_to new_user_session_path
  end

  test "shouldn't remove user, no permission" do
    sign_in @user
    delete :removeme, w_id: workspaces(:two), l_id: lists(:two), id: items(:two)
    assert_redirected_to workspaces_path
  end

  test "shouldn't remove user, not existed" do
    sign_in @user
    assert_difference('Item.count') do
      post :create, list_id: @list, item: { content: @item.content, due: @item.due }
    end
    assert_no_difference('assigns(:item).users.count') do
      delete :removeme, w_id: @workspace, l_id: @list, id: assigns(:item)
    end
    assert_redirected_to @workspace
  end

  test "should remove user" do
    sign_in @user
    assert_difference('@item.users.count',-1) do
      delete :removeme, w_id: @workspace, l_id: @list, id: @item
    end
    assert_redirected_to @workspace
  end


  test "shouldn't toggle done" do
#  POST   /workspaces/:w_id/items/:id/toggledone(.:format)           items#toggledone
    post :toggledone, w_id: @workspace, id: @item
    assert_redirected_to new_user_session_path
  end

  test "shouldn't toggle done, no permission" do
    sign_in @user
    post :toggledone, w_id: workspaces(:two), id: items(:two)
    assert_redirected_to workspaces_path
  end

  test "should toggle done" do
    sign_in @user
    post :toggledone, w_id: @workspace, id: @item
    assert_redirected_to @workspace
    assert_not_equal(@item.completed, assigns(:item).completed)
  end

end
