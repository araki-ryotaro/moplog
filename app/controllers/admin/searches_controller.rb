class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    if @range == "投稿者"
      @users = User.looks(params[:search], params[:word]).page(params[:page]).per(10)
    else
      @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(10)
    end
  end

end
