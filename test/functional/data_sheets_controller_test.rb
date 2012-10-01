require 'test_helper'

class DataSheetsControllerTest < ActionController::TestCase
  setup do
    @data_sheet = data_sheets(:ftp_main_data_sheet)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_sheet" do
    assert_difference('DataSheet.count') do
      post :create, :data_sheet => @data_sheet.attributes
    end

    assert_redirected_to data_sheet_path(assigns(:data_sheet))
  end

  test "should show data_sheet" do
    get :show, :id => @data_sheet.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @data_sheet.to_param
    assert_response :success
  end

  test "should update data_sheet" do
    put :update, :id => @data_sheet.to_param, :data_sheet => @data_sheet.attributes
    assert_redirected_to data_sheet_path(assigns(:data_sheet))
  end

  test "should destroy data_sheet" do
    assert_difference('DataSheet.count', -1) do
      delete :destroy, :id => @data_sheet.to_param
    end

    assert_redirected_to data_sheets_path
  end
end
