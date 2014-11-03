require 'test_helper'

class UserDoctorsControllerTest < ActionController::TestCase
  setup do
    @user_doctor = user_doctors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_doctors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_doctor" do
    assert_difference('UserDoctor.count') do
      post :create, user_doctor: {  }
    end

    assert_redirected_to user_doctor_path(assigns(:user_doctor))
  end

  test "should show user_doctor" do
    get :show, id: @user_doctor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_doctor
    assert_response :success
  end

  test "should update user_doctor" do
    put :update, id: @user_doctor, user_doctor: {  }
    assert_redirected_to user_doctor_path(assigns(:user_doctor))
  end

  test "should destroy user_doctor" do
    assert_difference('UserDoctor.count', -1) do
      delete :destroy, id: @user_doctor
    end

    assert_redirected_to user_doctors_path
  end
end
