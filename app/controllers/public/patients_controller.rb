class Public::PatientsController < ApplicationController
  before_action :authenticate_patient!

  def edit
    @patient = Patient.find(params[:id])
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def index
    @patient = Patient.find(params[:patient_id])
    @appointments = @patient.appointments.page(params[:page]).order(created_at: :desc)
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
       redirect_to public_patient_path(@patient), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
       render :edit
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:last_name,
    :first_name,
    :last_name_kana,
    :first_name_kana,
    :birthday,
    :gender,
    :email,
    :postal_code,
    :address,
    :telephone_number,
    :password,
    { infection_ids: []})
  end
end
