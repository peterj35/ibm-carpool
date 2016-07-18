class SessionsController < ApplicationController
  def new
  end

  def create 
    user = User.ldap_login(user_params)
    if user
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination, or cannot connect to Bluepages Server'
      render 'new'
    end
  end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def user_params
      params.require(:session)
        .permit(
          :email,
          :password,
          :remember_me,
        )
    end

end
