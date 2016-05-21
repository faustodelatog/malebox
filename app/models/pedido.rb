class Pedido < ActiveRecord::Base
  def items_json
    JSON.parse(items, object_class: OpenStruct)
  end

  def total_items
    items_json.reduce(0) {|sum, item| sum + item.producto.precio.to_f*item.cantidad.to_i }
  end

  def total
    (total_items + costo_entrega.to_f - descuento.to_f).round(2)
  end
end
