class ProductoCosa < ActiveRecord::Base
  belongs_to :cosa
  belongs_to :producto

  def quitar_de_inventario(inventario_id, pedido_id)
  	inventario_cosa = InventarioCosa.find_by(inventario: inventario_id, cosa_id: cosa.id)
  	inventario_cosa.quitar(cantidad, "Pedido: #{pedido_id} - Producto: #{producto.id}: #{producto.nombre}") if inventario_cosa
  end
end
