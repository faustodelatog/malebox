class Pedido < ActiveRecord::Base
  def items_json
    JSON.parse(items, object_class: OpenStruct)
  end

  def total_items
    # items_json.reduce(0) {|sum, item| sum + item.producto.precio_original.to_f*item.cantidad.to_i }.round(2)
    (total_items_con_descuento*1.15).round(2)
  end

  def total_items_con_descuento
    items_json.reduce(0) {|sum, item| sum + item.producto.precio.to_f*item.cantidad.to_i }.round(2)
  end

  def total_descuento
    total_con_descuento = 0
    total_con_descuento = total_items_con_descuento unless "TC".eql?(forma_pago)
    (total_items - total_con_descuento) + descuento.to_f 
  end

  def total
    (total_items + costo_entrega.to_f - total_descuento).round(2)
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
      when 'TC'
        str = 'Tarjeta de Crédito'
      else
        str = 'Otra forma de pago'
    end
    str
  end

  def calcular_costo sector_id
    sector = Sector.find(sector_id)
    costo = (total_items > 100 && sector.quito?) ? 2.98 : sector.costo
    # costo * numero_items
    costo
  end
end
