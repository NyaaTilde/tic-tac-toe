require 'test_helper'

class HomeWorksTest < ActionDispatch::IntegrationTest
  test "GET / 200 OK" do
    get "/"
    assert_response :success
  end
end
