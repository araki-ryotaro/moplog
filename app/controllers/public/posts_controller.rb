class Public::PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post.id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :description, :video)
  end
end
