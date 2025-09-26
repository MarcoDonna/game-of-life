require "test_helper"

class GameFramesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get game_frames_show_url
    assert_response :success
  end
end
