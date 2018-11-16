class EmpaquesController < AdminController
  before_action :set_empaque, only: [:show, :edit, :update, :destroy]

  # GET /empaques
  # GET /empaques.json
  def index
    @empaques = Empaque.all
  end

  # GET /empaques/1
  # GET /empaques/1.json
  def show
  end

  # GET /empaques/new
  def new
    @empaque = Empaque.new
  end

  # GET /empaques/1/edit
  def edit
  end

  # POST /empaques
  # POST /empaques.json
  def create
    @empaque = Empaque.new(empaque_params)

    respond_to do |format|
      if @empaque.save
        format.html { redirect_to @empaque, notice: 'Empaque was successfully created.' }
        format.json { render :show, status: :created, location: @empaque }
      else
        format.html { render :new }
        format.json { render json: @empaque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empaques/1
  # PATCH/PUT /empaques/1.json
  def update
    respond_to do |format|
      if @empaque.update(empaque_params)
        format.html { redirect_to @empaque, notice: 'Empaque was successfully updated.' }
        format.json { render :show, status: :ok, location: @empaque }
      else
        format.html { render :edit }
        format.json { render json: @empaque.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empaques/1
  # DELETE /empaques/1.json
  def destroy
    @empaque.destroy
    respond_to do |format|
      format.html { redirect_to empaques_url, notice: 'Empaque was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empaque
      @empaque = Empaque.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empaque_params
      params.require(:empaque).permit(:nombre, :url)
    end
end
