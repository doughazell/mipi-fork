require 'test_helper'

class GlobesControllerTest < ActionController::TestCase
  setup do
    @globe = globes(:one)
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
end
