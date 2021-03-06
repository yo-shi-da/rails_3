class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'アカウントを作成しました!!!こちらのページからログインして下さい！'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
        redirect_to user_path(@user.id), notice: 'アカウント内容を変更しました!!!'
      else
        render :edit
      end
    else
      redirect_to edit_user_path(@user.id), notice: 'パスワードが間違っています!!!'
    end      
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
