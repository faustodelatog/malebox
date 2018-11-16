require 'test_helper'

class InventarioCosasControllerTest < ActionController::TestCase
  setup do
    @inventario_cosa = inventario_cosas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventario_cosas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventario_cosa" do
    assert_difference('InventarioCosa.count') do
      post :create, inventario_cosa: { cantidad: @inventario_cosa.cantidad, cosa_id: @inventario_cosa.cosa_id, inventario: @inventario_cosa.inventario }
    end

    assert_redirected_to inventario_cosa_path(assigns(:inventario_cosa))
  end

  test "should show inventario_cosa" do
    get :show, id: @inventario_cosa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventario_cosa
    assert_response :success
  end

  test "should update inventario_cosa" do
    patch :update, id: @inventario_cosa, inventario_cosa: { cantidad: @inventario_cosa.cantidad, cosa_id: @inventario_cosa.cosa_id, inventario: @inventario_cosa.inventario }
    assert_redirected_to inventario_cosa_path(assigns(:inventario_cosa))
  end

  test "should destroy inventario_cosa" do
    assert_difference('InventarioCosa.count', -1) do
      delete :destroy, id: @inventario_cosa
    end

    assert_redirected_to inventario_cosas_path
  end
end
