class Cart
  attr_reader :items

  def initialize (cart, tapas)
    @items = cart.map { |producto_id, cantidad| Item.new(producto_id, cantidad, tapas ? tapas[producto_id] : nil)}
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

  def requiere_personalizacion?
    items.any? { |i| i.requiere_personalizacion? }
  end
end