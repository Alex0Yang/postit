class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(name: params[:name]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Username or password wrong!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash['notice'] = "You have logged out!"
    redirect_to root_path
  end

end
