class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    if @range == "投稿者"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end

end
