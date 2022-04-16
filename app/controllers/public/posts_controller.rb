class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.order(id: "DESC")
    @genres = Genre.all.order(id: "DESC")
  end

  def new
    @post = Post.new
    @user = current_user
    if @user.name != "ゲストユーザー"
      render :new
    else
      redirect_to posts_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post.id)
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @genres = Genre.all.order(id: "DESC")
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :description, :video)
  end
end
