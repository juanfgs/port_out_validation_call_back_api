require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  
  include Devise::Test::IntegrationHelpers
  test "should get index" do
    sign_in User.create(:email => "#{rand(50000)}@example.com")
    get welcome_index_url
    assert_response :success
  end

end
