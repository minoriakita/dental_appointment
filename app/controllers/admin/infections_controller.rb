class Admin::InfectionsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @infection = Infection.new
    @infections = Infection.page(params[:page])
  end

  def create
    @infection = Infection.new(infection_params)
    if @infection.save
       redirect_to admin_infections_path
    else
       @infections = Infection.page(params[:page])
       render :index
    end
  end

  def edit
    @infection = Infection.find(params[:id])
  end

  def update
    @infection = Infection.find(params[:id])
    if @infection.update(infection_params)
       redirect_to admin_infections_path
    else
       render :edit
    end
  end

 def destroy
    infection = Infection.find(params[:id])
    infection.update(is_deleted: true)
    redirect_to admin_infections_path
 end

  private

  def infection_params
    params.require(:infection).permit(:name)
  end
end
