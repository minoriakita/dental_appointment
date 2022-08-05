class Admin::PatientsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save(context: :admin)
      redirect_to admin_patient_path(@patient.id), notice: "登録が完了しました"
    else
      flash.now[:alert] = "登録が失敗しました"
      render "new"
    end
  end

  def index
    @patients = Patient.page(params[:page])
  end

  def search
      @patients = Patient.search(params[:keyword]).page(params[:page])
      @keyword = params[:keyword]
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.attributes = patient_params

    if @patient.save(context: :admin)
       redirect_to admin_patient_path(@patient), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
       render :edit
    end
  end

  #個人予約履歴
  def appointment_index
    @patient = Patient.find(params[:patient_id])
    @appointments = @patient.appointments.page(params[:page]).order(created_at: :desc)
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
