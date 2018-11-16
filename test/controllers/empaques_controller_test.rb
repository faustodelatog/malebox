require 'test_helper'

class EmpaquesControllerTest < ActionController::TestCase
  setup do
    @empaque = empaques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:empaques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create empaque" do
    assert_difference('Empaque.count') do
      post :create, empaque: { nombre: @empaque.nombre, url: @empaque.url }
    end

    assert_redirected_to empaque_path(assigns(:empaque))
  end

  test "should show empaque" do
    get :show, id: @empaque
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @empaque
    assert_response :success
  end

  test "should update empaque" do
    patch :update, id: @empaque, empaque: { nombre: @empaque.nombre, url: @empaque.url }
    assert_redirected_to empaque_path(assigns(:empaque))
  end

  test "should destroy empaque" do
    assert_difference('Empaque.count', -1) do
      delete :destroy, id: @empaque
    end

    assert_redirected_to empaques_path
  end
end
