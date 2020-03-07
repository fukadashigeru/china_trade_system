require 'test_helper'

class TaobaoColorSizesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get taobao_color_sizes_new_url
    assert_response :success
  end

  test "should get create" do
    get taobao_color_sizes_create_url
    assert_response :success
  end

  test "should get edit" do
    get taobao_color_sizes_edit_url
    assert_response :success
  end

  test "should get update" do
    get taobao_color_sizes_update_url
    assert_response :success
  end

end
