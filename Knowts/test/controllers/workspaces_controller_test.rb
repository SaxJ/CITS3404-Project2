require 'test_helper'

class WorkspacesControllerTest < ActionController::TestCase
  setup do
    @workspace = workspaces(:one)
    @user = users(:one)
    @request.env['HTTP_REFERER'] = workspaces_path
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:workspaces)
  end

  test "shouldn't get new" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "shouldn't create workspace" do
    assert_no_difference('Workspace.count') do
      post :create, workspace: { description: @workspace.description, name: @workspace.name }
    end
    assert_redirected_to new_user_session_path
  end

  test "shouldn't create workspace, invalid name" do
    sign_in @user
    assert_no_difference('Workspace.count') do
      post :create, workspace: { description: "desc", name: "" }
    end
  end

  test "should create workspace" do
    sign_in @user
    assert_difference('Workspace.count') do
      post :create, workspace: { description: "desc", name: "name" }
    end
    assert_redirected_to workspace_path(assigns(:workspace))
    assert_equal("desc", Workspace.find(assigns(:workspace)).description)
    assert_equal("name", Workspace.find(assigns(:workspace)).name)

  end

  test "shouldn't show workspace" do
    get :show, id: @workspace
    assert_redirected_to new_user_session_path
  end

  test "should show workspace" do
    sign_in @user
    get :show, id: @workspace
    assert_response :success
  end

  test "shouldn't get edit" do
    get :edit, id: @workspace
    assert_redirected_to new_user_session_path
  end

  test "shouldn't get edit, no permission" do
    sign_in @user
    get :edit, id: workspaces(:two)
    assert_redirected_to workspaces_path
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @workspace
    assert_response :success
  end

  test "shouldn't update workspace" do
    patch :update, id: @workspace, workspace: { description: @workspace.description, name: @workspace.name }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't update workspace, no permission" do
    sign_in @user
    patch :update, id: workspaces(:two), workspace: { description: @workspace.description, name: @workspace.name }
    assert_redirected_to workspaces_path
  end

  test "shouldn't update workspace, invalid name" do
    sign_in @user
    patch :update, id: @workspace, workspace: { description: "desc", name: "" }
    assert_not_equal("desc", Workspace.find(@workspace).description)
    assert_not_equal("", Workspace.find(@workspace).name)
  end

  test "should update workspace" do
    sign_in @user
    patch :update, id: @workspace, workspace: { description: @workspace.description, name: @workspace.name }
    assert_redirected_to workspace_path(assigns(:workspace))
  end

  test "shouldn't destroy workspace" do
    assert_no_difference('Workspace.count') do
      delete :destroy, id: @workspace
    end
    assert_redirected_to new_user_session_path
  end

  test "shouldn't destroy workspace, no permission" do
    sign_in @user
    assert_no_difference('Workspace.count') do
      delete :destroy, id: workspaces(:two)
    end
    assert_redirected_to workspaces_path
  end

  test "should destroy workspace" do
    sign_in @user
    assert_difference('Workspace.count') do
      post :create, workspace: { description: @workspace.description, name: @workspace.name }
    end
    assert_difference('Workspace.count', -1) do
      delete :destroy, id: assigns(:workspace)
    end

    assert_redirected_to workspaces_path
  end

  test "shouldn't remove user" do
    delete :removeuser, u_id: @user, w_id: @workspace
    assert_redirected_to new_user_session_path
  end

  test "shouldn't remove user, no permission" do
    sign_in @user
    delete :removeuser, u_id: @user, w_id: workspaces(:two)
    assert_redirected_to workspaces_path
  end

  test "shouldn't remove user, owner" do
    sign_in @user
    assert_difference('Workspace.count') do
      post :create, workspace: { description: @workspace.description, name: @workspace.name }
    end
    assert_no_difference('Workspace.count') do
      delete :removeuser, u_id: @user, w_id: assigns(:workspace)
    end
    assert_redirected_to assigns(:workspace)
  end


  test "should remove user" do
    sign_in @user
    delete :removeuser, u_id: @user, w_id: @workspace
    assert_redirected_to @workspace
  end

  test "shouldn't remove workspace" do
    delete :removeworkspace, u_id: @user, w_id: @workspace
    assert_redirected_to new_user_session_path
  end

  test "shouldn't remove workspace, no permission" do
    sign_in @user
    delete :removeworkspace, u_id: @user, w_id: workspaces(:two)
    assert_redirected_to workspaces_path
  end

  test "should remove workspace, no owner" do
    sign_in @user
    delete :removeworkspace, u_id: @user, w_id: @workspace
    assert_redirected_to workspaces_path
  end

  test "should remove workspace, owner" do
    sign_in @user
    assert_difference('Workspace.count') do
      post :create, workspace: { description: @workspace.description, name: @workspace.name }
    end
    assert_difference('Workspace.count', -1) do
      delete :removeworkspace, u_id: @user, w_id: assigns(:workspace)
    end
  end

  test "shouldn't add user" do
    post :adduser, id: @user
    assert_redirected_to new_user_session_path
  end

  test "shouldn't add user, no permission" do
    sign_in @user
    post :adduser, id: workspaces(:two)
    assert_redirected_to workspaces_path
  end

  test "shouldn't add user, not found" do
    sign_in @user
    post :adduser, id: @workspace, :email => "a@a.com"
    assert_redirected_to @workspace
  end

  test "should add user" do
    sign_in @user
    assert_difference("@workspace.users.count") do
      post :adduser, id: @workspace, :email => "two@two.com"
    end
    assert_redirected_to @workspace
  end

  test "shouldn't add user, exist" do
    sign_in @user
    assert_no_difference("@workspace.users.count") do
      post :adduser, id: @workspace, :email => "one@one.com"
    end
    assert_redirected_to @workspace
  end

end

