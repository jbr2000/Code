class LoginsController < ApplicationController
  def login
    if session[:user_id] && User.exists?(session[:user_id])
      redirect_to(home_path)
    end
  end

  def try_login
    unless User.exists?(params[:user_id])
      redirect_to(login_path) 
      return
    end
    @user = User.find(params[:user_id]).authenticate(params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to(home_path)
    else
      redirect_to(login_path)
    end
  end

  def logout
    reset_session
    redirect_to(login_path)
  end
end
