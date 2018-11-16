class ProductoCosasController < AdminController
  before_action :set_producto_cosa, only: [:show, :edit, :update, :destroy]

  # GET /producto_cosas
  # GET /producto_cosas.json
  def index
    @producto_cosas = ProductoCosa.all
  end

  # GET /producto_cosas/1
  # GET /producto_cosas/1.json
  def show
  end

  # GET /producto_cosas/new
  def new
    @producto_cosa = ProductoCosa.new
  end

  # GET /producto_cosas/1/edit
  def edit
  end

  # POST /producto_cosas
  # POST /producto_cosas.json
  def create
    @producto_cosa = ProductoCosa.new(producto_cosa_params)

    respond_to do |format|
      if @producto_cosa.save
        format.html { redirect_to @producto_cosa, notice: 'Producto cosa was successfully created.' }
        format.json { render :show, status: :created, location: @producto_cosa }
      else
        format.html { render :new }
        format.json { render json: @producto_cosa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /producto_cosas/1
  # PATCH/PUT /producto_cosas/1.json
  def update
    respond_to do |format|
      if @producto_cosa.update(producto_cosa_params)
        format.html { redirect_to @producto_cosa, notice: 'Producto cosa was successfully updated.' }
        format.json { render :show, status: :ok, location: @producto_cosa }
      else
        format.html { render :edit }
        format.json { render json: @producto_cosa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producto_cosas/1
  # DELETE /producto_cosas/1.json
  def destroy
    @producto_cosa.destroy
    respond_to do |format|
      format.html { redirect_to producto_cosas_url, notice: 'Producto cosa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto_cosa
      @producto_cosa = ProductoCosa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_cosa_params
      params.require(:producto_cosa).permit(:cosa_id, :producto_id, :cantidad)
    end
end
