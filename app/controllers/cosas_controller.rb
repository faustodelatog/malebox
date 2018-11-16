class CosasController < AdminController
  before_action :set_cosa, only: [:show, :edit, :update, :destroy]

  # GET /cosas
  # GET /cosas.json
  def index
    @cosas = Cosa.all
  end

  # GET /cosas/1
  # GET /cosas/1.json
  def show
  end

  # GET /cosas/new
  def new
    @cosa = Cosa.new
  end

  # GET /cosas/1/edit
  def edit
  end

  # POST /cosas
  # POST /cosas.json
  def create
    @cosa = Cosa.new(cosa_params)

    respond_to do |format|
      if @cosa.save
        format.html { redirect_to @cosa, notice: 'Cosa was successfully created.' }
        format.json { render :show, status: :created, location: @cosa }
      else
        format.html { render :new }
        format.json { render json: @cosa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cosas/1
  # PATCH/PUT /cosas/1.json
  def update
    respond_to do |format|
      if @cosa.update(cosa_params)
        format.html { redirect_to @cosa, notice: 'Cosa was successfully updated.' }
        format.json { render :show, status: :ok, location: @cosa }
      else
        format.html { render :edit }
        format.json { render json: @cosa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cosas/1
  # DELETE /cosas/1.json
  def destroy
    @cosa.destroy
    respond_to do |format|
      format.html { redirect_to cosas_url, notice: 'Cosa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cosa
      @cosa = Cosa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cosa_params
      params.require(:cosa).permit(:nombre, :url)
    end
end
