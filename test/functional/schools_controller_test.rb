require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  setup do
    @school = schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school" do
    assert_difference('School.count') do
      post :create, school: { access_type: @school.access_type, community_area: @school.community_area, cps_id: @school.cps_id, full_name: @school.full_name, latitude: @school.latitude, longitude: @school.longitude, school_type: @school.school_type, short_name: @school.short_name, street_address: @school.street_address }
    end

    assert_redirected_to school_path(assigns(:school))
  end

  test "should show school" do
    get :show, id: @school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school
    assert_response :success
  end

  test "should update school" do
    put :update, id: @school, school: { access_type: @school.access_type, community_area: @school.community_area, cps_id: @school.cps_id, full_name: @school.full_name, latitude: @school.latitude, longitude: @school.longitude, school_type: @school.school_type, short_name: @school.short_name, street_address: @school.street_address }
    assert_redirected_to school_path(assigns(:school))
  end

  test "should destroy school" do
    assert_difference('School.count', -1) do
      delete :destroy, id: @school
    end

    assert_redirected_to schools_path
  end
end
