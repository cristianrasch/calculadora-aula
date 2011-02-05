require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  test "index" do
    get :index
    
    assert_response :ok
    assert_template 'index'
  end
  
  test "about" do
    get :about
    
    assert_response :ok
    assert_template 'about'
  end
  
end
