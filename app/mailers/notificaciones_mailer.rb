class NotificacionesMailer < ActionMailer::Base

  def contactos_email (nombre, email, titulo, mensaje)
    @nombre = nombre
    @email = email
    @mensaje = mensaje
    info_mail = 'informacion@regalosmalebox.com'
    todos_mail = 'todos@regalosmalebox.com'
    mail(subject: "[CONTACTOS] #{titulo}", from: info_mail, to: todos_mail, reply_to: email)
  end
end