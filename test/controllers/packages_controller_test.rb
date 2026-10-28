require "test_helper"

class PackagesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get packages_search_url
    assert_response :success
  end
end
