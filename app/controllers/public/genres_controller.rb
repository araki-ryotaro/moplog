class Public::GenresController < ApplicationController
  before_action :authenticate_user!

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

end
