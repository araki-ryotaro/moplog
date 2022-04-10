class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    @posts = Post.where(genre_id: @genre.id)
    @genres = Genre.all
  end

end
