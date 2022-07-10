class Admin::SymptomsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @symptom = Symptom.new
    @symptoms = Symptom.page(params[:page])
  end

  def create
    @symptom = Symptom.new(symptom_params)
    if @symptom.save
       redirect_to admin_symptoms_path
    else
       @symptoms = Symptom.page(params[:page])
       render :index
    end
  end

  def edit
    @symptom = Symptom.find(params[:id])
  end

  def update
    @symptom = Symptom.find(params[:id])
    if @symptom.update(symptom_params)
       redirect_to admin_symptoms_path
    else
       render :edit
    end
  end

 def destroy
    symptom = Symptom.find(params[:id])
    symptom.update(is_deleted: true)
    redirect_to admin_symptoms_path
 end

  private

  def symptom_params
    params.require(:symptom).permit(:name)
  end
end
