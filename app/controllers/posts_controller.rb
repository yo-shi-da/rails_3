class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]
  skip_before_action :login_required, only: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "作成しました!!!"
    else
      render :new
    end
  end

  def show
    if logged_in?
      @post = Post.find(params[:id])
      @favorite = current_user.favorites.find_by(post_id: @post.id)
    else
      redirect_to posts_path, notice: "ログインしないと見れないよ？"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "削除しました。"
  end

  def confirm
    @post = current_user.posts.new(post_params)
  end

  private
  
  def post_params
    params.require(:post).permit(:content, :image, :image_cache, :user_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

end
