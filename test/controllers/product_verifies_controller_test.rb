require 'test_helper'

class ProductVerifiesControllerTest < ActionController::TestCase
  setup do
    @product_verify = product_verifies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_verifies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_verify" do
    assert_difference('ProductVerify.count') do
      post :create, product_verify: { product_id: @product_verify.product_id, product_verify_type_id: @product_verify.product_verify_type_id, status: @product_verify.status }
    end

    assert_redirected_to product_verify_path(assigns(:product_verify))
  end

  test "should show product_verify" do
    get :show, id: @product_verify
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_verify
    assert_response :success
  end

  test "should update product_verify" do
    patch :update, id: @product_verify, product_verify: { product_id: @product_verify.product_id, product_verify_type_id: @product_verify.product_verify_type_id, status: @product_verify.status }
    assert_redirected_to product_verify_path(assigns(:product_verify))
  end

  test "should destroy product_verify" do
    assert_difference('ProductVerify.count', -1) do
      delete :destroy, id: @product_verify
    end

    assert_redirected_to product_verifies_path
  end
end
