class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :log_in?, :need_log_in, :require_same_user_to_edit_profile, :require_same_user_to_edit_post

  def current_user
    @logged_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def log_in?
    !!current_user
  end

  def need_log_in
    unless log_in?
      flash[:error] = "You need log in."
      redirect_to login_path
    end
  end

  def require_same_user_to_edit_profile
    if current_user.id.to_s != params[:id]
      flash[:error] = "Your're not allowed!"
      redirect_to root_path
    end
  end

  def require_same_user_to_edit_post
    unless current_user.posts.include?(Post.find_by(slug: params[:id]))
      flash[:error] = "You're not allowed to edit this post. "
      redirect_to root_path
    end
  end
end
