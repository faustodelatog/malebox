class PedidosMailer < ActionMailer::Base

  def checkout_email pedido_id
    @pedido = Pedido.find pedido_id
    info_mail = 'info@regalosmalebox.com'
    mail(subject: "[PEDIDO] #{@pedido.nombre} - #{@pedido.telefono} (Que BIEN!!!)", from: info_mail, to: info_mail, reply_to: @pedido.email)
  end

  def checkout_user_email pedido_id
    @pedido = Pedido.find pedido_id
    info_mail = 'info@regalosmalebox.com'
    mail(subject: "¡¡ Ordenaste una MaleBox !!", from: info_mail, to: @pedido.email, reply_to: 'noreply@regalosmalebox.com')
  end
end