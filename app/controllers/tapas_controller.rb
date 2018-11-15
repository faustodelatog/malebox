class TapasController < AdminController
  before_action :set_tapa, only: [:show, :edit, :update, :destroy]

  # GET /tapas
  # GET /tapas.json
  def index
    @tapas = Tapa.all
  end

  # GET /tapas/1
  # GET /tapas/1.json
  def show
  end

  # GET /tapas/new
  def new
    @tapa = Tapa.new
  end

  # GET /tapas/1/edit
  def edit
  end

  # POST /tapas
  # POST /tapas.json
  def create
    @tapa = Tapa.new(tapa_params)

    respond_to do |format|
      if @tapa.save
        format.html { redirect_to @tapa, notice: 'Tapa was successfully created.' }
        format.json { render :show, status: :created, location: @tapa }
      else
        format.html { render :new }
        format.json { render json: @tapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tapas/1
  # PATCH/PUT /tapas/1.json
  def update
    respond_to do |format|
      if @tapa.update(tapa_params)
        format.html { redirect_to @tapa, notice: 'Tapa was successfully updated.' }
        format.json { render :show, status: :ok, location: @tapa }
      else
        format.html { render :edit }
        format.json { render json: @tapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tapas/1
  # DELETE /tapas/1.json
  def destroy
    @tapa.destroy
    respond_to do |format|
      format.html { redirect_to tapas_url, notice: 'Tapa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tapa
      @tapa = Tapa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tapa_params
      params.require(:tapa).permit(:nombre, :url, :categoria, :descripcion, :variables)
    end
end
