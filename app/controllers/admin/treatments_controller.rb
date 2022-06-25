class Admin::TreatmentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @treatment = Treatment.new
    @treatments = Treatment.page(params[:page])
  end

  def create
    @treatment = Treatment.new(treatment_params)
    if @treatment.save
       redirect_to admin_treatments_path
    else
       @treatments = Treatment.all
       render :index
    end
  end

  def edit
    @treatment = Treatment.find(params[:id])
  end

  def update
    @treatment = Treatment.find(params[:id])
    if @treatment.update(treatment_params)
       redirect_to admin_treatments_path
    else
       render :edit
    end
  end

 def destroy
    treatment = Treatment.find(params[:id])
    treatment.delete
    redirect_to admin_treatments_path
 end

  private

  def treatment_params
    params.require(:treatment).permit(:name)
  end
end
