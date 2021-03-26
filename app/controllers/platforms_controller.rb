class PlatformsController < ApplicationController
	def create
    platform_id = params[:platform][:platform_id]

    @game = Game.find(params[:game_id])

    @platform = Platform.find(platform_id)
    @game.platforms << @platform
    if @game.save
      redirect_to game_path(@game)
    else
      render 'new'
		end
  end

  def new
    @game = Game.find(params[:game_id])
    @platform = Platform.new
  end
end
