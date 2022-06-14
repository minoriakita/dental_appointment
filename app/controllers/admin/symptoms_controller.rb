class Admin::SymptomsController < ApplicationController
  def index
    @symptom = Symptom.new
    @symptoms = Symptom.all
  end

  def create
    @symptom = Symptom.new(symptom_params)
    @symptom.save
    redirect_to admin_symptoms_path
  end

  def edit
    @symptom = Symptom.find(params[:id])
  end

  def update
    @symptom = Symptom.find(params[:id])
    @symptom.update(symptom_params)
    redirect_to admin_symptoms_path
  end

 def destroy
    symptom = Symptom.find(params[:id])
    symptom.delete
    redirect_to admin_symptoms_path
 end

  private

  def symptom_params
    params.require(:symptom).permit(:name)
  end
end
