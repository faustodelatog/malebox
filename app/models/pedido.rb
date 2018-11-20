class Pedido < ActiveRecord::Base
  def items_json
    JSON.parse(items, object_class: OpenStruct)
  end

  def total_items
    # items_json.reduce(0) {|sum, item| sum + item.producto.precio_original.to_f*item.cantidad.to_i }.round(2)
    (total_items_con_descuento*1.06).round(0)
  end

  def total_items_con_descuento
    items_json.reduce(0) {|sum, item| sum + item.producto.precio.to_f*item.cantidad.to_i }.round(2)
  end

  def total_descuento
    total_con_descuento = total_items
    total_con_descuento = total_items_con_descuento unless "TC".eql?(forma_pago) || "PP".eql?(forma_pago)
    ((total_items - total_con_descuento) + descuento.to_f).round(2) 
  end

  def total_tapas
    con_tapa_personalizada ? (5 * numero_items).to_f.round(2) : 0.00;
  end

  def total
    (total_items + total_tapas + costo_entrega.to_f - total_descuento).round(2)
  end

  def sin_iva
    (total / 1.12).round(2)
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

  def realizar
    self.estado = 'Pendiente'
    self.fecha = DateTime.now
    self.save

    PedidosMailer.checkout_email(self.id).deliver_later
    PedidosMailer.checkout_user_email(self.id).deliver_later
  end

  def pagar_paypal (tx)
    self.realizar
    self.pagar

    self.estado = "Pagado Paypal"
    self.paypal_tx = tx
    self.save!

    p "Pago con paypal confirmado para pedido #{self.id} - #{self.estado}"
  end

  def pagar
    self.estado = "Pagado"
    self.save!
  end

  def armar(inventario_id, producto_cosas_ids)
    items_json.each{|i| quitar_de_inventario(inventario_id, i.producto.id, i.cantidad.to_i, producto_cosas_ids)}
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

  def pendiente?
    self.estado.casecmp('pendiente') == 0
  end

  def pagado?
    self.estado.downcase.include?('pagado')
  end

  def armado?
    self.estado.casecmp('armado') == 0
  end

  def cancelado?
    self.estado.casecmp('cancelado') == 0
  end

  def quitar_de_inventario (inventario_id, producto_id, cantidad, producto_cosas_ids)
    producto = Producto.find(producto_id)
    cantidad.times do
       producto.quitar_de_inventario(inventario_id, id, producto_cosas_ids)
    end 
  end
end
