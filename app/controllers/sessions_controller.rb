class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to posts_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました!!!'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました!!!'
    redirect_to new_session_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end

end
