require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  #fixtures :all
  #fixtures :users
  
  test "login" do
    get "/"
    assert_response :success
	
    # 4/7/13 DH: Request to "/" is redirected to "/users/sign_in" with 302 reponse code (by devise engine) 
    #            which causes the browser to make a 2nd request to the new URL specified in the Location Field 
    #            and hence returns ':success' (ie 200 OK)
    #assert_redirected_to user_session_path
	
    #post_via_redirect "/users/sign_in", :email => "paul123@piguard.com", :password => "paul123"
    #post_via_redirect 'users/sign_in', 'user[email]' => 'paul123@piguard.com', 'user[password]' => 'paul123'
    post_via_redirect user_session_path, 'user[email]' => 'paul123@piguard.com', 'user[password]' => 'paul123' 
	
    #assert_equal "Invalid email or password.", flash[:alert]
	
    # 4/7/13 DH: Success has a 'flash[:notice]' not 'flash[:alert]'
    assert_equal "Signed in successfully.", flash[:notice]
    #assert_equal "Signed in successfully.", flash[:alert]
  end

  test "should PASS since valid fixtures assigned globe subdomain" do
    
    host! "ftp.lvh.me"
    
    get "/"
    #assert_response :success
    assert_redirected_to user_session_path
    
    post_via_redirect user_session_path, 'user[email]' => 'paul123@piguard.com', 'user[password]' => 'paul123' 
    assert_equal "Signed in successfully.", flash[:notice]
    
  end  

  test "should FAIL since non-fixtures assigned globe subdomain" do
    
    host! "spud.lvh.me"
    
    get "/"
    #assert_response :success
    assert_redirected_to user_session_path
    
    post_via_redirect user_session_path, 'user[email]' => 'paul123@piguard.com', 'user[password]' => 'paul123' 
    assert_equal "Requested subdomain is invalid!  Fucking get a life!!!", $invalidSubdomain[:msg]
    
  end

end
