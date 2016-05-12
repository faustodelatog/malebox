class CheckoutController < ApplicationController
  def index
    @pedido = JSON.parse(session[:pedido], object_class: Pedido)
  end

  def purchase
    pedido = JSON.parse(session[:pedido], object_class: Pedido)
    pedido_id = save_pedido pedido

    session[:pedido_id] = pedido_id
    session[:cart_id] = nil
    session[:pedido] = nil

    PedidosMailer.checkout_email(pedido_id).deliver_later
    PedidosMailer.checkout_user_email(pedido_id).deliver_later

    redirect_to controller: 'checkout', action: 'confirmacion'
  end

  def confirmacion
    pedido_id = session[:pedido_id].to_i
    @pedido = Pedido.find pedido_id
  end

  def cancel
    redirect_to controller: 'cart', action: 'index'
  end

  def save_pedido pedido
    pedido.estado = 'Pendiente'
    pedido.save
    pedido.id
  end
end
