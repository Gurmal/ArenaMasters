require 'test_helper'

class EventControllerTest < ActionDispatch::IntegrationTest
  test "should get buildSchedule" do
    get event_buildSchedule_url
    assert_response :success
  end

end
