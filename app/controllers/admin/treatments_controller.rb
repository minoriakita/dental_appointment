class Admin::TreatmentsController < ApplicationController
  def index
    @treatment = Treatment.new
    @treatments = Treatment.all
  end

  def create
    @treatment = Treatment.new(treatment_params)
    @treatment.save
    redirect_to admin_treatments_path
  end

  def edit
    @treatment = Treatment.find(params[:id])
  end

  def update
    @treatment = Treatment.find(params[:id])
    @treatment.update(treatment_params)
    redirect_to admin_treatments_path
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
