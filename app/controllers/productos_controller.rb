class ProductosController < ApplicationController
  
  # GET /productos
  # GET /productos.json
  def index
    busqueda = "#{params['search']}"
    categoria = "#{params['categoria']}"

    if !busqueda.empty?
      @productos = Producto.where("nombre like ? or descripcion like ?", "%#{busqueda}%", "%#{busqueda}%")
      @busqueda = busqueda
    else
      if !categoria.empty?
        @productos = CategoriaProducto.where("categorium_id = ?", categoria).map{ |cp| cp.producto }
        @categoria = Categorium.where("id = ?", categoria).first
      else
        @productos = Producto.all
      end
    end
    @productos = @productos.sort_by { |p| p.orden }
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    @producto = Producto.find_by_id(params[:id])
    @related_productos = Producto.all.sample(3)
  end
end
