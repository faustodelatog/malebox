class CheckoutController < ApplicationController
  def index
    @pedido = Pedido.find(session[:pedido_id]) if session[:pedido_id]
    redirect_to controller: 'cart', action: 'index' if !@pedido
  end

  def purchase
    pedido_id = session[:pedido_id]
    pedido = Pedido.find(pedido_id)
    update_pedido pedido

    PedidosMailer.checkout_email(pedido_id).deliver_later
    PedidosMailer.checkout_user_email(pedido_id).deliver_later

    redirect_to controller: 'checkout', action: 'confirmacion', confirm_pedido_id: pedido_id
  end

  def confirmacion
    confirm_pedido_id = params['confirm_pedido_id']
    @pedido = Pedido.find(confirm_pedido_id) if confirm_pedido_id
    if @pedido
      session[:cart_id] = nil
      session[:tapas] = nil
      session[:pedido_id] = nil
    end
    redirect_to controller: 'checkout', action: 'index' if !@pedido
  end

  def cancel
    redirect_to controller: 'cart', action: 'index'
  end

  def update_pedido pedido
    pedido.estado = 'Pendiente'
    pedido.save
  end

  def confirm_paypal
    pedido = Pedido.find params['confirm_pedido_id']
    p "Confirmando pago paypal para pedido #{pedido.id} - #{pedido.estado}"
    return 200 if pedido.estado.casecmp('Borrador') != 0

    pedido.estado = "Pagado Paypal (#{params['txn_id']})"
    pedido.save

    PedidosMailer.checkout_email(pedido.id).deliver_later
    PedidosMailer.checkout_user_email(pedido.id).deliver_later

    p "Pago con paypal confirmado para pedido #{pedido.id} - #{pedido.estado}"
    201
  end
end
