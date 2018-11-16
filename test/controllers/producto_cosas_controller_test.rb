require 'test_helper'

class ProductoCosasControllerTest < ActionController::TestCase
  setup do
    @producto_cosa = producto_cosas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producto_cosas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producto_cosa" do
    assert_difference('ProductoCosa.count') do
      post :create, producto_cosa: { cantidad: @producto_cosa.cantidad, cosa_id: @producto_cosa.cosa_id, producto_id: @producto_cosa.producto_id }
    end

    assert_redirected_to producto_cosa_path(assigns(:producto_cosa))
  end

  test "should show producto_cosa" do
    get :show, id: @producto_cosa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @producto_cosa
    assert_response :success
  end

  test "should update producto_cosa" do
    patch :update, id: @producto_cosa, producto_cosa: { cantidad: @producto_cosa.cantidad, cosa_id: @producto_cosa.cosa_id, producto_id: @producto_cosa.producto_id }
    assert_redirected_to producto_cosa_path(assigns(:producto_cosa))
  end

  test "should destroy producto_cosa" do
    assert_difference('ProductoCosa.count', -1) do
      delete :destroy, id: @producto_cosa
    end

    assert_redirected_to producto_cosas_path
  end
end
