class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

	private
	
	# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:warning] = "Please sign up or log in. You must have an account to offer a ride!"
			redirect_to login_url
		end
	end

end
