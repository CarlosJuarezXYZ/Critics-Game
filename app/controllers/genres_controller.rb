class GenresController < ApplicationController
  def create
    genre_id = params[:genre][:genre_id]
    pp params
    @game = Game.find(params[:game_id])

    @genre = Genre.find(genre_id)
    @game.genres << @genre
    if @game.save
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

  def new
    @game = Game.find(params[:game_id])
    @genre = Genre.new
  end
end
