class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all.order(id: "DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @genres = Genre.all.order(id: "DESC").page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :description, :video)
  end
end
