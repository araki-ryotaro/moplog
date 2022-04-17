class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(id: "DESC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(id: "DESC").page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def unsubscribe
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end