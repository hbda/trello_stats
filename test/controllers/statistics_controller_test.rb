require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get collect" do
    get :collect
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
