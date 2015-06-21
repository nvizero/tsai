require 'test_helper'

class ProductOrdersControllerTest < ActionController::TestCase
  setup do
    @product_order = product_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_order" do
    assert_difference('ProductOrder.count') do
      post :create, product_order: { code: @product_order.code, member_id: @product_order.member_id, order_state_id: @product_order.order_state_id, state: @product_order.state }
    end

    assert_redirected_to product_order_path(assigns(:product_order))
  end

  test "should show product_order" do
    get :show, id: @product_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_order
    assert_response :success
  end

  test "should update product_order" do
    patch :update, id: @product_order, product_order: { code: @product_order.code, member_id: @product_order.member_id, order_state_id: @product_order.order_state_id, state: @product_order.state }
    assert_redirected_to product_order_path(assigns(:product_order))
  end

  test "should destroy product_order" do
    assert_difference('ProductOrder.count', -1) do
      delete :destroy, id: @product_order
    end

    assert_redirected_to product_orders_path
  end
end
