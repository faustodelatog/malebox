class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token

  before_action :set_locale
  before_action :verify_selected_city

  def set_locale
    I18n.locale = params[:locale] || :es
  end

  def verify_selected_city
  	city = session[:selected_city]
    redirect_to controller: 'city', action: 'index' unless city
  end
end
