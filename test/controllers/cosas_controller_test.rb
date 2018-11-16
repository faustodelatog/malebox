require 'test_helper'

class CosasControllerTest < ActionController::TestCase
  setup do
    @cosa = cosas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cosas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cosa" do
    assert_difference('Cosa.count') do
      post :create, cosa: { nombre: @cosa.nombre, url: @cosa.url }
    end

    assert_redirected_to cosa_path(assigns(:cosa))
  end

  test "should show cosa" do
    get :show, id: @cosa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cosa
    assert_response :success
  end

  test "should update cosa" do
    patch :update, id: @cosa, cosa: { nombre: @cosa.nombre, url: @cosa.url }
    assert_redirected_to cosa_path(assigns(:cosa))
  end

  test "should destroy cosa" do
    assert_difference('Cosa.count', -1) do
      delete :destroy, id: @cosa
    end

    assert_redirected_to cosas_path
  end
end
