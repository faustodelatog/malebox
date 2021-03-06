class InventarioCosasController < AdminController
  before_action :set_inventario_cosa, only: [:show, :edit, :update, :destroy]

  # GET /inventario_cosas
  # GET /inventario_cosas.json
  def index
    @inventario_cosas = InventarioCosa.all
    @inventario = params[:inventario]
    @nombre = params[:nombre]

    @inventario_cosas = @inventario_cosas.where(inventario: @inventario) if @inventario
    @inventario_cosas = @inventario_cosas.joins(:cosa).where("cosas.nombre ilike ?", "%#{@nombre}%") if @nombre

    @inventario_cosas = @inventario_cosas.sort{|x,y| x.salud_i <=> y.salud_i}

  end

  # GET /inventario_cosas/1
  # GET /inventario_cosas/1.json
  def show
    accion = params[:accion]
    render 'add' and return if accion == 'add'
    render 'remove' and return if accion == 'remove'
  end

  def add_remove
    inventario_cosa = InventarioCosa.find(params[:id])
    cantidad = params[:cantidad]
    notas = params[:notas]
    case params[:accion]
    when 'A'
      inventario_cosa.agregar(cantidad, notas)
    when 'R'
      inventario_cosa.quitar(cantidad, notas)
    else
      p 'No hay ninguna accion'
    end

    redirect_to inventario_cosas_path
  end

  # GET /inventario_cosas/new
  def new
    @inventario_cosa = InventarioCosa.new
  end

  # GET /inventario_cosas/1/edit
  def edit
  end

  # POST /inventario_cosas
  # POST /inventario_cosas.json
  def create
    @inventario_cosa = InventarioCosa.new(inventario_cosa_params)

    respond_to do |format|
      if @inventario_cosa.save
        format.html { redirect_to @inventario_cosa, notice: 'Inventario cosa was successfully created.' }
        format.json { render :show, status: :created, location: @inventario_cosa }
      else
        format.html { render :new }
        format.json { render json: @inventario_cosa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventario_cosas/1
  # PATCH/PUT /inventario_cosas/1.json
  def update
    respond_to do |format|
      if @inventario_cosa.update(inventario_cosa_params)
        format.html { redirect_to @inventario_cosa, notice: 'Inventario cosa was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventario_cosa }
      else
        format.html { render :edit }
        format.json { render json: @inventario_cosa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventario_cosas/1
  # DELETE /inventario_cosas/1.json
  def destroy
    @inventario_cosa.destroy
    respond_to do |format|
      format.html { redirect_to inventario_cosas_url, notice: 'Inventario cosa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventario_cosa
      @inventario_cosa = InventarioCosa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventario_cosa_params
      params.require(:inventario_cosa).permit(:cosa_id, :inventario, :cantidad)
    end
end
