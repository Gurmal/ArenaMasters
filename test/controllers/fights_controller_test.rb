require 'test_helper'

class FightsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get fights_show_url
    assert_response :success
  end

end
