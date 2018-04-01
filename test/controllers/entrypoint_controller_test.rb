require 'test_helper'

class EntrypointControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get entrypoint_index_url
    assert_response :success
  end

end
