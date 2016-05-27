require 'test_helper'

class ProductVerifyContentsControllerTest < ActionController::TestCase
  setup do
    @product_verify_content = product_verify_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_verify_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_verify_content" do
    assert_difference('ProductVerifyContent.count') do
      post :create, product_verify_content: {  }
    end

    assert_redirected_to product_verify_content_path(assigns(:product_verify_content))
  end

  test "should show product_verify_content" do
    get :show, id: @product_verify_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_verify_content
    assert_response :success
  end

  test "should update product_verify_content" do
    patch :update, id: @product_verify_content, product_verify_content: {  }
    assert_redirected_to product_verify_content_path(assigns(:product_verify_content))
  end

  test "should destroy product_verify_content" do
    assert_difference('ProductVerifyContent.count', -1) do
      delete :destroy, id: @product_verify_content
    end

    assert_redirected_to product_verify_contents_path
  end
end
