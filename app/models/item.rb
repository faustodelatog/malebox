class Item
  attr_reader :producto
  attr_reader :cantidad
  attr_accessor :tapa_personalizada

  def initialize(producto_id, cantidad, tapa)
    @producto = Producto.find(producto_id)
    @cantidad = cantidad
    @tapa_personalizada = TapaPersonalizada.new(tapa.tapa_id, tapa.variables) if tapa && tapa.tapa_id
  end

  def total
    producto.precio*cantidad
  end

  def total_original
    producto.precio_original*cantidad
  end
end