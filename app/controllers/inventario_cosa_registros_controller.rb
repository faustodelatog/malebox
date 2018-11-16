class InventarioCosaRegistrosController < AdminController
  before_action :set_inventario_cosa_registro, only: [:show, :edit, :update, :destroy]

  # GET /inventario_cosa_registros
  # GET /inventario_cosa_registros.json
  def index
    @inventario_cosa_registros = InventarioCosaRegistro.all
  end

  # GET /inventario_cosa_registros/1
  # GET /inventario_cosa_registros/1.json
  def show
  end

  # GET /inventario_cosa_registros/new
  def new
    @inventario_cosa_registro = InventarioCosaRegistro.new
  end

  # GET /inventario_cosa_registros/1/edit
  def edit
  end

  # POST /inventario_cosa_registros
  # POST /inventario_cosa_registros.json
  def create
    @inventario_cosa_registro = InventarioCosaRegistro.new(inventario_cosa_registro_params)

    respond_to do |format|
      if @inventario_cosa_registro.save
        format.html { redirect_to @inventario_cosa_registro, notice: 'Inventario cosa registro was successfully created.' }
        format.json { render :show, status: :created, location: @inventario_cosa_registro }
      else
        format.html { render :new }
        format.json { render json: @inventario_cosa_registro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventario_cosa_registros/1
  # PATCH/PUT /inventario_cosa_registros/1.json
  def update
    respond_to do |format|
      if @inventario_cosa_registro.update(inventario_cosa_registro_params)
        format.html { redirect_to @inventario_cosa_registro, notice: 'Inventario cosa registro was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventario_cosa_registro }
      else
        format.html { render :edit }
        format.json { render json: @inventario_cosa_registro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventario_cosa_registros/1
  # DELETE /inventario_cosa_registros/1.json
  def destroy
    @inventario_cosa_registro.destroy
    respond_to do |format|
      format.html { redirect_to inventario_cosa_registros_url, notice: 'Inventario cosa registro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventario_cosa_registro
      @inventario_cosa_registro = InventarioCosaRegistro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventario_cosa_registro_params
      params.require(:inventario_cosa_registro).permit(:inventario_cosa_id, :tipo, :cantidad, :notas)
    end
end
