require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test 'index' do
    get :index

    assert_response :success
    assert_match 'Sign in with Github', response.body
  end
end
