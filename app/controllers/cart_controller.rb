# cart_controller.rb
class CartController < ApplicationController
  def add_to_cart
    product_id = params[:product_id]
    add_product product_id
    redirect_to controller: 'cart', action: 'index'
  end

  def add_product (product_id)
    cart = session[:cart_id] || {}
    quantity = cart[product_id] || 0
    cart[product_id] = quantity + 1 if quantity < 1

    session[:cart_id] = cart
  end

  def remove_from_cart
    product_id = params[:product_id]
    remove_product product_id
    redirect_to controller: 'cart', action: 'index'
  end

  def remove_product (product_id)
    cart = session[:cart_id] || {}
    quantity = cart[product_id] || 0
    cart[product_id] = quantity - 1 if quantity > 1

    session[:cart_id] = cart
  end

  def remove_all_from_cart
    product_id = params[:product_id]
    remove_all_product product_id
    redirect_to controller: 'cart', action: 'index'
  end

  def remove_all_product (product_id)
    cart = session[:cart_id]
    cart.delete(product_id)

    session[:cart_id] = cart
  end

  def index
    @cart = Cart.new(session[:cart_id], session[:tapas]) if session[:cart_id]
    @cart = nil if @cart && (!@cart.items || @cart.items.empty?)
    pedido = Pedido.find(session[:pedido_id]) if session[:pedido_id]
    @fe = pedido ? pedido.fecha_entrega: params['fecha_entrega'] ||= 'Fecha Entrega'
    @ea = pedido ? pedido.nombre_entrega: params['nombre_entrega'] ||= 'Entregar a'
    @cd = pedido ? pedido.telefono_receptor: params['telefono_receptor'] ||= 'Celular Destinatario'
    @de = pedido ? pedido.direccion_entrega: params['direccion'] ||= 'Dirección de entrega'
    @ie = pedido ? pedido.instrucciones_entrega: params['instrucciones'] ||= 'ej.: Letra L para mi vaso personalizado (Depende de regalo). Dejar regalo en portería. Notificar entrega. etc.'
    @se = pedido ? pedido.sector_entrega: params['sector'] ||= ''
    @he = pedido ? pedido.horario_entrega: params['horario_entrega'] ||= ''
    @nde = pedido ? pedido.de: params['nombre_de'] ||= 'De parte de'
    @npara = pedido ? pedido.para: params['nombre_para'] ||= 'Para'
    @mt = pedido ? pedido.mensaje: params['mensaje'] ||= 'Mensaje de tarjeta'
    @email = pedido ? pedido.email: params['email'] ||= 'Email'
    @nombre = pedido ? pedido.nombre: params['nombre'] ||= 'Nombre'
    @telefono = pedido ? pedido.telefono: params['telefono'] ||= 'Teléfono'
    @tapa = pedido ? pedido.con_tapa_personalizada: 'on'.eql?(params['con_tapa_personalizada']) ? true : false
    @ubicacion = pedido ? pedido.punto_entrega: params['punto_entrega'] ||= ''
    @tapa = ""
  end

  def add_tapa_personalizada
    tapas = session[:tapas] || {}
    param_tapa_id = "tapa_#{params['tapa_id']}_"
    variables = params.select{|k,v| k.include?(param_tapa_id)}.map{|k,v| "#{k.gsub(param_tapa_id,'')}:#{v}"}.join(', ')
    tapas[params['product_id']] = OpenStruct.new({tapa_id: params['tapa_id'], variables: variables})

    session[:tapas] = tapas
    if params['tapa_id'].nil?
      @error = 'Selecciona un diseño personalizado'
      render 'tapa'
      return
    end
    @cart = Cart.new(session[:cart_id], session[:tapas])
    render 'tapa'
  end

  def checkout
    cart = Cart.new(session[:cart_id], session[:tapas])
    email = params['email']
    nombre = params['nombre']
    telefono = params['telefono']
    direccion = params['direccion']
    nombre_entrega = params['nombre_entrega']
    telefono_receptor = params['telefono_receptor']
    mensaje = params['mensaje']
    fecha_entrega = params['fecha_entrega']
    forma_pago = params['forma_pago']
    instrucciones = params['instrucciones']
    sector = params['sector']
    horario_entrega = params['horario_entrega']
    de = params['nombre_de']
    para = params['nombre_para']
    punto_entrega = params['punto_entrega']
    con_tapa_personalizada = 'on'.eql?(params['con_tapa_personalizada']) ? true : false

    error = validate(email, nombre, telefono, nombre_entrega, direccion, mensaje, fecha_entrega, sector, de, para, punto_entrega, telefono_receptor)
    error = 'Olvidaste personalizar tu regalo. Puedes hacerlo, es GRATIS' if error.empty? && cart.requiere_personalizacion?
    if error.empty?
      pedido_id = create_pedido(cart.items, nombre, email, telefono, direccion, nombre_entrega, mensaje, fecha_entrega, forma_pago, instrucciones, sector, de, para, horario_entrega, punto_entrega, con_tapa_personalizada, telefono_receptor)
      session[:pedido_id] = pedido_id

      redirect_to controller: 'checkout', action: 'index'
    else
      flash[:alert] = error
      redirect_to controller: 'cart', action: 'index', params: params
    end

  end

  def validate(email, nombre, telefono, nombre_entrega, direccion, mensaje, fecha_entrega, sector, de, para, punto_entrega, telefono_receptor)

  day_names = ['domingo','lunes','martes','miercoles','jueves','viernes','sabado','domingo']
  month_names = [nil, 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  return 'ingresa una fecha de entrega' if fecha_entrega.strip.empty? || fecha_entrega.eql?('Fecha Entrega')
    christmas = Date.new(2018, 12, 24)
    dec14 = Date.new(2018, 12, 14)
    mensaje_fecha_entrega = "Oops! Nuestras entregas están copadas para la fecha requerida, elige otra fecha de entrega"
    return mensaje_fecha_entrega if (Date.parse(fecha_entrega) == christmas || Date.parse(fecha_entrega) == dec14)
    return 'ingresa el nombre a quién debe ser entregada la caja' if (nombre_entrega.strip.empty? || nombre_entrega.eql?('Entregar a'))
    return 'selecciona el sector de entrega ' if (sector.strip.empty? || sector.eql?('Sector'))
    return 'ingresa la dirección de entrega' if (direccion.strip.empty? || direccion.eql?('Dirección de entrega'))

    return 'ingresa tu email válido para contactarte' if !is_a_valid_email?(email)
    return 'ingresa tu nombre para contactarte' if (nombre.strip.empty? || nombre.eql?('Nombre'))
    return 'ingresa tu teléfono para contactarte' if (telefono.strip.empty? || telefono.eql?('Teléfono'))

    return 'ingresa el mensaje de la tarjeta' if (mensaje.strip.empty? || mensaje.eql?('Mensaje de tarjeta'))
    return 'ingresa el nombre de la persona que entrega la tarjeta (De parte de)' if (de.strip.empty? || de.eql?('De parte de'))
    return 'ingresa el nombre de la persona que recibe la tarjeta (Para)' if (para.strip.empty? || para.eql?('Para'))
    # return 'ubica el punto de entrega en el mapa' if (punto_entrega.strip.empty?)

    return ''
  end

  def is_a_valid_email?(email)
    (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

  def create_pedido items, nombre, email, telefono, direccion, nombre_entrega, mensaje, fecha_entrega, forma_pago, instrucciones, sector, de, para, horarioEntrega, punto_entrega, con_tapa_personalizada, telefono_receptor
    pedido = Pedido.find(session[:pedido_id]) if session[:pedido_id]
    pedido = Pedido.new unless pedido
    pedido.fecha = Time.now.in_time_zone('Quito').to_date

    pedido.items = items.to_json

    pedido.nombre = nombre
    pedido.email = email
    pedido.telefono = telefono

    pedido.direccion_entrega = direccion
    pedido.nombre_entrega = nombre_entrega
    pedido.telefono_receptor = telefono_receptor == 'Celular Destinatario' ? '' : telefono_receptor
    pedido.fecha_entrega = fecha_entrega
    pedido.forma_pago = forma_pago
    pedido.instrucciones_entrega = instrucciones
    pedido.sector_entrega = sector
    pedido.horario_entrega = horarioEntrega
    pedido.punto_entrega = punto_entrega
    pedido.con_tapa_personalizada = con_tapa_personalizada

    pedido.de = de
    pedido.para = para
    pedido.mensaje = mensaje

    pedido.costo_entrega = pedido.calcular_costo sector

    pedido.estado = 'Borrador'

    pedido.save

    pedido.id
  end
end
