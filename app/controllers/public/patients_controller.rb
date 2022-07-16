class Public::PatientsController < ApplicationController
  before_action :authenticate_patient!

  def edit
    @patient = Patient.find(params[:id])
  end
  
  def show
    @patient = Patient.find(params[:id])
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
       redirect_to admin_patient_path(@patient), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
       render :edit
    end
  end

  def appointment_index
    @patient = Patient.find(params[:patient_id])
    @appointments = @patient.appointments.page(params[:page]).order(created_at: :desc)
  end
  
end
