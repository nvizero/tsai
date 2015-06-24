require 'test_helper'

class UserBelongsControllerTest < ActionController::TestCase
  setup do
    @user_belong = user_belongs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_belongs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_belong" do
    assert_difference('UserBelong.count') do
      post :create, user_belong: { belong_user_id: @user_belong.belong_user_id, user_id: @user_belong.user_id }
    end

    assert_redirected_to user_belong_path(assigns(:user_belong))
  end

  test "should show user_belong" do
    get :show, id: @user_belong
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_belong
    assert_response :success
  end

  test "should update user_belong" do
    patch :update, id: @user_belong, user_belong: { belong_user_id: @user_belong.belong_user_id, user_id: @user_belong.user_id }
    assert_redirected_to user_belong_path(assigns(:user_belong))
  end

  test "should destroy user_belong" do
    assert_difference('UserBelong.count', -1) do
      delete :destroy, id: @user_belong
    end

    assert_redirected_to user_belongs_path
  end
end
