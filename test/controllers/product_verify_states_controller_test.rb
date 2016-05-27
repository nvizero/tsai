require 'test_helper'

class ProductVerifyStatesControllerTest < ActionController::TestCase
  setup do
    @product_verify_state = product_verify_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_verify_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_verify_state" do
    assert_difference('ProductVerifyState.count') do
      post :create, product_verify_state: { create_user_id: @product_verify_state.create_user_id, modify_user_id: @product_verify_state.modify_user_id, stoped_at: @product_verify_state.stoped_at, stoped_user_id: @product_verify_state.stoped_user_id, title: @product_verify_state.title }
    end

    assert_redirected_to product_verify_state_path(assigns(:product_verify_state))
  end

  test "should show product_verify_state" do
    get :show, id: @product_verify_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_verify_state
    assert_response :success
  end

  test "should update product_verify_state" do
    patch :update, id: @product_verify_state, product_verify_state: { create_user_id: @product_verify_state.create_user_id, modify_user_id: @product_verify_state.modify_user_id, stoped_at: @product_verify_state.stoped_at, stoped_user_id: @product_verify_state.stoped_user_id, title: @product_verify_state.title }
    assert_redirected_to product_verify_state_path(assigns(:product_verify_state))
  end

  test "should destroy product_verify_state" do
    assert_difference('ProductVerifyState.count', -1) do
      delete :destroy, id: @product_verify_state
    end

    assert_redirected_to product_verify_states_path
  end
end
