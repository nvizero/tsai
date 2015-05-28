require 'test_helper'

class ProductVerifyTypesControllerTest < ActionController::TestCase
  setup do
    @product_verify_type = product_verify_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_verify_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_verify_type" do
    assert_difference('ProductVerifyType.count') do
      post :create, product_verify_type: { content: @product_verify_type.content, name: @product_verify_type.name }
    end

    assert_redirected_to product_verify_type_path(assigns(:product_verify_type))
  end

  test "should show product_verify_type" do
    get :show, id: @product_verify_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_verify_type
    assert_response :success
  end

  test "should update product_verify_type" do
    patch :update, id: @product_verify_type, product_verify_type: { content: @product_verify_type.content, name: @product_verify_type.name }
    assert_redirected_to product_verify_type_path(assigns(:product_verify_type))
  end

  test "should destroy product_verify_type" do
    assert_difference('ProductVerifyType.count', -1) do
      delete :destroy, id: @product_verify_type
    end

    assert_redirected_to product_verify_types_path
  end
end
