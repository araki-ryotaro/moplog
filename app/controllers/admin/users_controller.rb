class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(id: "DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(id: "DESC").page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
