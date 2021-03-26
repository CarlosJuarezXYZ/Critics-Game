class CriticsController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @critic = Critic.new
  end

  def edit
    @game = Game.find(params[:game_id])
    @critic = @game.critics.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @criticable = params[:game_id] ?
    Game.find(params[:game_id]) :
    User.find(params[:user_id])
    @critic = @criticable.critics.new(critic_params)
    @critic.user = current_user
    if @critic.save
      redirect_to @criticable
    else
      render 'new'
    end
  end
  
  def update
    @game = Game.find(params[:game_id])
    @critic = @game.critics.find(params[:id])
    if @critic.update(critic_params)
      redirect_to @game
    else
      render 'edit'
    end
  end
  
  def destroy
    @game = Game.find(params[:game_id])
    @critic = @game.critics.find(params[:id])
    @critic.destroy

    redirect_to @game
  end
  
  
  

  private

  def critic_params
    params.require(:critic).permit(:title, :user_id, :body)
  end
  
end
