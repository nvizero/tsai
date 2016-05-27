require 'test_helper'

class WaitOrdersControllerTest < ActionController::TestCase
  setup do
    @wait_order = wait_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wait_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wait_order" do
    assert_difference('WaitOrder.count') do
      post :create, wait_order: { code: @wait_order.code, create_user_id: @wait_order.create_user_id, modify_user_id: @wait_order.modify_user_id, num: @wait_order.num, product_id: @wait_order.product_id, save_date: @wait_order.save_date, serial: @wait_order.serial, state: @wait_order.state, stop_user_id: @wait_order.stop_user_id, stoped_at: @wait_order.stoped_at }
    end

    assert_redirected_to wait_order_path(assigns(:wait_order))
  end

  test "should show wait_order" do
    get :show, id: @wait_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wait_order
    assert_response :success
  end

  test "should update wait_order" do
    patch :update, id: @wait_order, wait_order: { code: @wait_order.code, create_user_id: @wait_order.create_user_id, modify_user_id: @wait_order.modify_user_id, num: @wait_order.num, product_id: @wait_order.product_id, save_date: @wait_order.save_date, serial: @wait_order.serial, state: @wait_order.state, stop_user_id: @wait_order.stop_user_id, stoped_at: @wait_order.stoped_at }
    assert_redirected_to wait_order_path(assigns(:wait_order))
  end

  test "should destroy wait_order" do
    assert_difference('WaitOrder.count', -1) do
      delete :destroy, id: @wait_order
    end

    assert_redirected_to wait_orders_path
  end
end
