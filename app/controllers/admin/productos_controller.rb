class Admin::ProductosController < Admin::BaseController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  # GET /admin/productos
  # GET /admin/productos.json
  def index
    @productos = Producto.all.sort_by { |p| p.orden }
  end

  # GET /admin/productos/1
  # GET /admin/productos/1.json
  def show
  end

  # GET /admin/productos/new
  def new
    @producto = Producto.new
  end

  # GET /admin/productos/1/edit
  def edit
  end

  # POST /admin/productos
  # POST /admin/productos.json
  def create
    @producto = Producto.new(producto_params)

    respond_to do |format|
      if @producto.save
        format.html { redirect_to admin_producto_url(@producto), notice: 'Producto was successfully created.' }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/productos/1
  # PATCH/PUT /admin/productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to admin_producto_url(@producto), notice: 'Producto was successfully updated.' }
        format.json { render :show, status: :ok, location: @producto }
      else
        format.html { render :edit }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/productos/1
  # DELETE /admin/productos/1.json
  def destroy
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to admin_productos_url, notice: 'Producto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:nombre, :descripcion, :foto_url, :precio, :orden, :ciudadesMismoDia, :empaque_id)
    end
end
