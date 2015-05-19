require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get post_username" do
    get :post_username
    assert_response :success
  end

end
