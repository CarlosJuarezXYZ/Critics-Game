class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to games_path
    else
      render 'new'
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to games_path
    else
      render 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to games_path
  end

  private 

  def company_params
    params.require(:company).permit(:name, :description, :start_date, :country)
  end
end
