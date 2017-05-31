class CityController < ActionController::Base

	def index
		@city = session[:selected_city]
	end

	def select
		session[:selected_city] = params[:ciudad]
		redirect_to controller: 'page', action: 'home'
	end
end