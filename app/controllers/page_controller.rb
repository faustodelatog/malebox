class PageController < ApplicationController
  def home
    @productos = Producto.all.sample(6)
    @categorias = Categorium.all
  end

  def contactos
  end

  def send_email
    # if verify_recaptcha
    if true
      NotificacionesMailer.contactos_email(params['nombre'], params['email'], params['titulo'], params['mensaje']).deliver_now
      flash.now[:alert] = "Mail enviado exitósamente, nos pondremos en contacto pronto!"
      render :contactos
    else
      flash.now[:alert] = "Hubo  un error en la validación del captcha. Por favor inténtelo de nuevo"
      flash.delete :recaptcha_error
      render :contactos
    end
  end
end
