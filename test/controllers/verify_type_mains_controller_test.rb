require 'test_helper'

class VerifyTypeMainsControllerTest < ActionController::TestCase
  setup do
    @verify_type_main = verify_type_mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verify_type_mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verify_type_main" do
    assert_difference('VerifyTypeMain.count') do
      post :create, verify_type_main: { content: @verify_type_main.content, title: @verify_type_main.title }
    end

    assert_redirected_to verify_type_main_path(assigns(:verify_type_main))
  end

  test "should show verify_type_main" do
    get :show, id: @verify_type_main
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @verify_type_main
    assert_response :success
  end

  test "should update verify_type_main" do
    patch :update, id: @verify_type_main, verify_type_main: { content: @verify_type_main.content, title: @verify_type_main.title }
    assert_redirected_to verify_type_main_path(assigns(:verify_type_main))
  end

  test "should destroy verify_type_main" do
    assert_difference('VerifyTypeMain.count', -1) do
      delete :destroy, id: @verify_type_main
    end

    assert_redirected_to verify_type_mains_path
  end
end
