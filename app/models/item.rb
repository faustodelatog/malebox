class Item
  attr_reader :producto
  attr_reader :cantidad

  def initialize(producto_id, cantidad)
    @producto = Producto.find(producto_id)
    @cantidad = cantidad
  end

  def total
    producto.precio*cantidad
  end

  def total_original
    producto.precio_original*cantidad
  end
end