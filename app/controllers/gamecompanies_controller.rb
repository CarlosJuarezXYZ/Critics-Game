class GamecompaniesController < ApplicationController

	def new
    @game = Game.find(params[:game_id])
    @companies = Company.new
	end
	
  def create
    companies_id = params[:company][:company_id]
    
    @game = Game.find(params[:game_id])

    @companies = Company.find(companies_id)
		# found = found_company(game.companies, company_id)

    @game.companies << @companies
    if @game.save
      redirect_to game_path(@game)
    else
      render 'new'
    end
	end
end
