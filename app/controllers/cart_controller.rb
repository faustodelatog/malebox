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
    cart[product_id] = quantity + 1 if quantity < 10

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
    @cart = Cart.new(session[:cart_id]) if session[:cart_id]
    pedido = Pedido.find(session[:pedido_id]) if session[:pedido_id]
    @fe = pedido ? pedido.fecha_entrega: 'Fecha Entrega'
    @ea = pedido ? pedido.nombre_entrega: 'Entregar a'
    @de = pedido ? pedido.direccion_entrega: 'Dirección Entrega'
    @mt = pedido ? pedido.mensaje: 'Mensaje de tarjeta'
    @email = pedido ? pedido.email: 'Email'
    @nombre = pedido ? pedido.nombre: 'Nombre'
    @telefono = pedido ? pedido.telefono: 'Teléfono'
  end

  def checkout
    cart = Cart.new(session[:cart_id])
    email = params['email']
    nombre = params['nombre']
    telefono = params['telefono']
    direccion = params['direccion']
    nombre_entrega = params['nombre_entrega']
    mensaje = params['mensaje']
    fecha_entrega = params['fecha_entrega']
    forma_pago = params['forma_pago']

    if validate email, nombre, telefono, nombre_entrega, direccion, mensaje, fecha_entrega
      pedido_id = create_pedido(cart.items, nombre, email, telefono, direccion, nombre_entrega, mensaje, fecha_entrega, forma_pago)
      session[:pedido_id] = pedido_id

      redirect_to controller: 'checkout', action: 'index'
    else
      flash[:alert] = "Por favor ingrese toda la información requerida"
      redirect_to controller: 'cart', action: 'index'
    end

  end

  def validate(email, nombre, telefono, nombre_entrega, direccion, mensaje, fecha_entrega)
    !((!is_a_valid_email?(email)) ||
        (nombre.strip.empty? || nombre.eql?('Nombre')) ||
        (nombre_entrega.strip.empty? || nombre_entrega.eql?('Entregar a')) ||
        (direccion.strip.empty? || direccion.eql?('Dirección de entrega')) ||
        (mensaje.strip.empty? || mensaje.eql?('Mensaje de tarjeta')) ||
        (fecha_entrega.strip.empty?) ||
        (telefono.strip.empty? || telefono.eql?('Teléfono')))
  end

  def is_a_valid_email?(email)
    (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

  def create_pedido items, nombre, email, telefono, direccion, nombre_entrega, mensaje, fecha_entrega, forma_pago
    pedido = Pedido.find(session[:pedido_id]) if session[:pedido_id]
    pedido = Pedido.new unless pedido
    pedido.fecha = Date.today
    pedido.items = items.to_json

    pedido.nombre = nombre
    pedido.email = email
    pedido.telefono = telefono

    pedido.direccion_entrega = direccion
    pedido.nombre_entrega = nombre_entrega
    pedido.mensaje = mensaje
    pedido.fecha_entrega = fecha_entrega
    pedido.costo_entrega = 2.98
    pedido.forma_pago = forma_pago

    pedido.estado = 'Borrador'

    pedido.save

    pedido.id
  end
end