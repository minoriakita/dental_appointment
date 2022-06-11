class Admin::PatientsController < ApplicationController

  def new
    @patient = Patient.new
  end

  def create
    patient = Patient.new(patient_params)
    patient.save
    redirect_to admin_patient_path(@patient.id)
  end

  def index
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update(patient_params)
    redirect_to admin_patient_path(@patient)
  end

  private

  def patient_params
    params.require(:patient).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, :gender, :email, :postal_code, :address, :telephone_number)
  end
end
