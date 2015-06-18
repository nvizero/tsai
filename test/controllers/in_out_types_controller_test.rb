require 'test_helper'

class InOutTypesControllerTest < ActionController::TestCase
  setup do
    @in_out_type = in_out_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:in_out_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create in_out_type" do
    assert_difference('InOutType.count') do
      post :create, in_out_type: { create_user_id: @in_out_type.create_user_id, modify_user_id: @in_out_type.modify_user_id, stop_user_id: @in_out_type.stop_user_id, stoped_at: @in_out_type.stoped_at, title: @in_out_type.title, type: @in_out_type.type }
    end

    assert_redirected_to in_out_type_path(assigns(:in_out_type))
  end

  test "should show in_out_type" do
    get :show, id: @in_out_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @in_out_type
    assert_response :success
  end

  test "should update in_out_type" do
    patch :update, id: @in_out_type, in_out_type: { create_user_id: @in_out_type.create_user_id, modify_user_id: @in_out_type.modify_user_id, stop_user_id: @in_out_type.stop_user_id, stoped_at: @in_out_type.stoped_at, title: @in_out_type.title, type: @in_out_type.type }
    assert_redirected_to in_out_type_path(assigns(:in_out_type))
  end

  test "should destroy in_out_type" do
    assert_difference('InOutType.count', -1) do
      delete :destroy, id: @in_out_type
    end

    assert_redirected_to in_out_types_path
  end
end
