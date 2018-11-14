class PedidosController < AdminController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]

  # GET /pedidos
  # GET /pedidos.json
  def index
    @from = "#{params['from']}".to_date rescue nil
    @to = "#{params['to']}".to_date rescue nil
    @estado = "#{params['estado']}"

    p "filtering by from: #{@from} & to: #{@to} & estado: #{@estado}"
   
    @pedidos = Pedido.all
    p "pedidos: #{@pedidos.size}"
    if @from
      @pedidos = @pedidos.where("fecha_entrega >= (?)", @from)
      p "from: #{@pedidos.size}"
    end
    if @to
      @pedidos = @pedidos.where("fecha_entrega <= (?)", @to)
      p "to: #{@pedidos.size}"
    end
    if @estado
      @pedidos = @pedidos.where("estado ilike ? ", "%#{@estado}%")
      p "estado: #{@pedidos.size}"
    end
    
    @estados = Pedido.select('distinct lower(estado) estado').map(&:estado)
    @pedidos = @pedidos.sort_by { |p| [p.fecha_entrega ? 0 : 1, p.fecha_entrega || 0]}.reverse
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(pedido_params)

    respond_to do |format|
      if @pedido.save
        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render :show, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
        format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
        format.json { render :show, status: :ok, location: @pedido }
      else
        format.html { render :edit }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit!
    end
end
