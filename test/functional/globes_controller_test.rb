require 'test_helper'

class GlobesControllerTest < ActionController::TestCase

  # 24/7/13 DH: Functional testing is not appropriate here since we use the Devise engine.
  #             This needs to be done as an integration test!
  test "should fail since invalid globe subdomain" do
    @request.host = "spud.lvh.me"
    get :index
    #assert_response :success
    assert_redirected_to user_session_path
  end

=begin
  setup do
    @globe = globes(:ftp)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:globes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create globe" do
    assert_difference('Globe.count') do
      post :create, :globe => @globe.attributes
    end

    assert_redirected_to globe_path(assigns(:globe))
  end

  test "should show globe" do
    get :show, :id => @globe.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @globe.to_param
    assert_response :success
  end

  test "should update globe" do
    put :update, :id => @globe.to_param, :globe => @globe.attributes
    assert_redirected_to globe_path(assigns(:globe))
  end

  test "should destroy globe" do
    assert_difference('Globe.count', -1) do
      delete :destroy, :id => @globe.to_param
    end

    assert_redirected_to globes_path
  end
=end

end
