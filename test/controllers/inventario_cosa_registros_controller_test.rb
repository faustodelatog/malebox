require 'test_helper'

class InventarioCosaRegistrosControllerTest < ActionController::TestCase
  setup do
    @inventario_cosa_registro = inventario_cosa_registros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventario_cosa_registros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventario_cosa_registro" do
    assert_difference('InventarioCosaRegistro.count') do
      post :create, inventario_cosa_registro: { cantidad: @inventario_cosa_registro.cantidad, inventario_cosa_id: @inventario_cosa_registro.inventario_cosa_id, notas: @inventario_cosa_registro.notas, tipo: @inventario_cosa_registro.tipo }
    end

    assert_redirected_to inventario_cosa_registro_path(assigns(:inventario_cosa_registro))
  end

  test "should show inventario_cosa_registro" do
    get :show, id: @inventario_cosa_registro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventario_cosa_registro
    assert_response :success
  end

  test "should update inventario_cosa_registro" do
    patch :update, id: @inventario_cosa_registro, inventario_cosa_registro: { cantidad: @inventario_cosa_registro.cantidad, inventario_cosa_id: @inventario_cosa_registro.inventario_cosa_id, notas: @inventario_cosa_registro.notas, tipo: @inventario_cosa_registro.tipo }
    assert_redirected_to inventario_cosa_registro_path(assigns(:inventario_cosa_registro))
  end

  test "should destroy inventario_cosa_registro" do
    assert_difference('InventarioCosaRegistro.count', -1) do
      delete :destroy, id: @inventario_cosa_registro
    end

    assert_redirected_to inventario_cosa_registros_path
  end
end
