class InventarioProductosController < AdminController
  def index
  	@productos = Producto.all
  end

  def show
  	@producto = Producto.find(params[:id])
  	@cosas = @producto.producto_cosas
  	cosas_ids = @cosas.map{|c| c.cosa.id}
  	@cosas += Cosa.where.not(id: cosas_ids).map{|c| ProductoCosa.new({cosa: c})}
  end

  def update
  	producto_cosas = params.select{|k,v| k.include?('cosa') && !v.empty?}.map{|k,v| ProductoCosa.new({cosa_id:k.gsub('cosa',''), cantidad:v.to_i})}
  	@producto = Producto.find(params[:id])
  	@producto.producto_cosas = producto_cosas
  	@producto.save!
  	redirect_to inventario_productos_path
  end
end
