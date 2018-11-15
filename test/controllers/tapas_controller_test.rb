require 'test_helper'

class TapasControllerTest < ActionController::TestCase
  setup do
    @tapa = tapas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tapas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tapa" do
    assert_difference('Tapa.count') do
      post :create, tapa: { categoria: @tapa.categoria, descripcion: @tapa.descripcion, nombre: @tapa.nombre, url: @tapa.url, variables: @tapa.variables }
    end

    assert_redirected_to tapa_path(assigns(:tapa))
  end

  test "should show tapa" do
    get :show, id: @tapa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tapa
    assert_response :success
  end

  test "should update tapa" do
    patch :update, id: @tapa, tapa: { categoria: @tapa.categoria, descripcion: @tapa.descripcion, nombre: @tapa.nombre, url: @tapa.url, variables: @tapa.variables }
    assert_redirected_to tapa_path(assigns(:tapa))
  end

  test "should destroy tapa" do
    assert_difference('Tapa.count', -1) do
      delete :destroy, id: @tapa
    end

    assert_redirected_to tapas_path
  end
end
