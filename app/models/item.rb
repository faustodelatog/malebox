class Item
  attr_reader :producto
  attr_reader :cantidad
  attr_accessor :tapa_personalizada

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

  def add_tapa(tapa_id, variables)
    tapa_personalizada = TapaPersonalizada.new(tapa_id, variables)
  end
end