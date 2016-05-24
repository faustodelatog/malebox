class NotificacionesMailer < ActionMailer::Base

  def contactos_email (nombre, email, titulo, mensaje)
    @nombre = nombre
    @email = email
    @mensaje = mensaje
    info_mail = 'info@regalosmalebox.com'
    mail(subject: "[CONTACTOS] #{titulo}", from: info_mail, to: info_mail, reply_to: email)
  end
end