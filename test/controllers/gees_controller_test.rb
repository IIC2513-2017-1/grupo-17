require 'test_helper'

class GeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gee = gees(:one)
  end

  test "should get index" do
    get gees_url
    assert_response :success
  end

  test "should get new" do
    get new_gee_url
    assert_response :success
  end

  test "should create gee" do
    assert_difference('Gee.count') do
      post gees_url, params: { gee: { category_id: @gee.category_id, description: @gee.description, expiration_date: @gee.expiration_date, name: @gee.name, user_id: @gee.user_id } }
    end

    assert_redirected_to gee_url(Gee.last)
  end

  test "should show gee" do
    get gee_url(@gee)
    assert_response :success
  end

  test "should get edit" do
    get edit_gee_url(@gee)
    assert_response :success
  end

  test "should update gee" do
    patch gee_url(@gee), params: { gee: { category_id: @gee.category_id, description: @gee.description, expiration_date: @gee.expiration_date, name: @gee.name, user_id: @gee.user_id } }
    assert_redirected_to gee_url(@gee)
  end

  test "should destroy gee" do
    assert_difference('Gee.count', -1) do
      delete gee_url(@gee)
    end

    assert_redirected_to gees_url
  end
end
