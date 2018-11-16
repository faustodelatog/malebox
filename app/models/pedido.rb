class Pedido < ActiveRecord::Base
  def items_json
    JSON.parse(items, object_class: OpenStruct)
  end

  def total_items
    # items_json.reduce(0) {|sum, item| sum + item.producto.precio_original.to_f*item.cantidad.to_i }.round(2)
    (total_items_con_descuento*1.06).round(2)
  end

  def total_items_con_descuento
    items_json.reduce(0) {|sum, item| sum + item.producto.precio.to_f*item.cantidad.to_i }.round(2)
  end

  def total_descuento
    total_con_descuento = total_items
    total_con_descuento = total_items_con_descuento unless "TC".eql?(forma_pago)
    ((total_items - total_con_descuento) + descuento.to_f).round(2) 
  end

  def total_tapas
    con_tapa_personalizada ? (5 * numero_items).to_f.round(2) : 0.00;
  end

  def total
    (total_items + total_tapas + costo_entrega.to_f - total_descuento).round(2)
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
    costo = (total_items_con_descuento > 200 && sector.quito?) ? 2.98 : sector.costo
    costo = 0 if "PD".eql?(sector_id)
    # costo * numero_items
    costo
  end

  def ubicacion
    return "https://www.google.com/maps/search/#{punto_entrega.gsub(';', ',')}" if punto_entrega
    "https://www.google.com/maps/search/0,0"
  end

  def armar(inventario_id)
    items_json.each{|i| quitar_de_inventario(inventario_id, i.producto.id, i.cantidad.to_i)}
    self.estado = 'Armado'
    self.save!
  end

  def entregar
    self.estado = 'Entregado'
    self.save!
  end

  def cancelar
    self.estado = 'Cancelado'
    self.save!
  end

  def quitar_de_inventario (inventario_id, producto_id, cantidad)
    producto = Producto.find(producto_id)
    cantidad.times do
       producto.quitar_de_inventario(inventario_id, id)
    end 
  end
end
