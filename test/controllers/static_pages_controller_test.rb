require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "IBM Carpool Buddy"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | IBM Carpool Buddy"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | IBM Carpool Buddy"
  end

end
