class Cart
  attr_reader :items

  def initialize (cart, tapas)
   @items = cart.map { |producto_id, cantidad| Item.new(producto_id, cantidad)}
   tapas.each {|producto_id, tapa| add_tapa_personalizada(producto_id, tapa.tapa_id, tapa.variables)} if tapas
  end

  def total
    items.reduce(0) {|sum, item| sum + item.producto.precio*item.cantidad }
  end

  def total_original
    items.reduce(0) {|sum, item| sum + item.producto.precio_original*item.cantidad }
  end

  def permite_tapa_personalizada
    items.any? { |item| item.producto.permite_tapa_personalizada}
  end

  def add_tapa_personalizada(producto_id, tapa_id, variables)
    item = items.select{|i| i.producto.id == producto_id}.first
    item.add_tapa(tapa_id, variables)
  end
end