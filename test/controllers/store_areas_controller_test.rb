require 'test_helper'

class StoreAreasControllerTest < ActionController::TestCase
  setup do
    @store_area = store_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:store_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store_area" do
    assert_difference('StoreArea.count') do
      post :create, store_area: { area_id: @store_area.area_id, area_name: @store_area.area_name }
    end

    assert_redirected_to store_area_path(assigns(:store_area))
  end

  test "should show store_area" do
    get :show, id: @store_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store_area
    assert_response :success
  end

  test "should update store_area" do
    patch :update, id: @store_area, store_area: { area_id: @store_area.area_id, area_name: @store_area.area_name }
    assert_redirected_to store_area_path(assigns(:store_area))
  end

  test "should destroy store_area" do
    assert_difference('StoreArea.count', -1) do
      delete :destroy, id: @store_area
    end

    assert_redirected_to store_areas_path
  end
end
