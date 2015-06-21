require 'test_helper'

class OrderByProductsControllerTest < ActionController::TestCase
  setup do
    @order_by_product = order_by_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_by_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_by_product" do
    assert_difference('OrderByProduct.count') do
      post :create, order_by_product: { num: @order_by_product.num, product_id: @order_by_product.product_id, product_order_id: @order_by_product.product_order_id }
    end

    assert_redirected_to order_by_product_path(assigns(:order_by_product))
  end

  test "should show order_by_product" do
    get :show, id: @order_by_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_by_product
    assert_response :success
  end

  test "should update order_by_product" do
    patch :update, id: @order_by_product, order_by_product: { num: @order_by_product.num, product_id: @order_by_product.product_id, product_order_id: @order_by_product.product_order_id }
    assert_redirected_to order_by_product_path(assigns(:order_by_product))
  end

  test "should destroy order_by_product" do
    assert_difference('OrderByProduct.count', -1) do
      delete :destroy, id: @order_by_product
    end

    assert_redirected_to order_by_products_path
  end
end
