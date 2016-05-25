class Pedido < ActiveRecord::Base
  def items_json
    JSON.parse(items, object_class: OpenStruct)
  end

  def total_items
    items_json.reduce(0) {|sum, item| sum + item.producto.precio.to_f*item.cantidad.to_i }.round(2)
  end

  def total
    (total_items + costo_entrega.to_f - descuento.to_f).round(2)
  end

  def numero_items
    items_json.reduce(0) {|sum, item| sum + item.cantidad.to_i }
  end

  def descripcion
    descripcion = ''
    items_json.each do |i|
      descripcion += "#{i.cantidad} #{i.producto.nombre} - "
    end
    descripcion += "**"
    descripcion.gsub('- **', '')
  end

  def forma_pago_str
    str = 'Sin forma de pago'
    case forma_pago
      when 'T'
        str = 'Transferencia'
      when 'D'
        str = 'Depósito'
      when 'E'
        str = 'Efectivo'
      when 'PP'
        str = 'PayPal'
      else
        str = 'Otra forma de pago'
    end
    str
  end
end
