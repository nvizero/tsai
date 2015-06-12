require 'test_helper'

class ProductInOutsControllerTest < ActionController::TestCase
  setup do
    @product_in_out = product_in_outs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_in_outs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_in_out" do
    assert_difference('ProductInOut.count') do
      post :create, product_in_out: { code: @product_in_out.code, create_user_id: @product_in_out.create_user_id, in_or_out: @product_in_out.in_or_out, modify_user_id: @product_in_out.modify_user_id, num: @product_in_out.num, product_id: @product_in_out.product_id, stop_user_id: @product_in_out.stop_user_id, stoped_at: @product_in_out.stoped_at }
    end

    assert_redirected_to product_in_out_path(assigns(:product_in_out))
  end

  test "should show product_in_out" do
    get :show, id: @product_in_out
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_in_out
    assert_response :success
  end

  test "should update product_in_out" do
    patch :update, id: @product_in_out, product_in_out: { code: @product_in_out.code, create_user_id: @product_in_out.create_user_id, in_or_out: @product_in_out.in_or_out, modify_user_id: @product_in_out.modify_user_id, num: @product_in_out.num, product_id: @product_in_out.product_id, stop_user_id: @product_in_out.stop_user_id, stoped_at: @product_in_out.stoped_at }
    assert_redirected_to product_in_out_path(assigns(:product_in_out))
  end

  test "should destroy product_in_out" do
    assert_difference('ProductInOut.count', -1) do
      delete :destroy, id: @product_in_out
    end

    assert_redirected_to product_in_outs_path
  end
end
