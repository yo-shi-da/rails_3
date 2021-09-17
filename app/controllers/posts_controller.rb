class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = current_user.posts
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
  end

  def edit
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
