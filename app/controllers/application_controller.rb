class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

	private
	
	# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

  # Confirms a logged in, admin user.
  def logged_in_admin_user
		if !logged_in?
			flash[:danger] = "Please log in."
			redirect_to(root_url)
		else
    	redirect_to(root_url) unless current_user.admin?
  	end
	end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    flash[:danger] = "Incorrect User"
    redirect_to(root_url) unless current_user?(@user)
  end

end
