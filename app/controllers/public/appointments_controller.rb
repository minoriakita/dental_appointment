class Public::AppointmentsController < ApplicationController
   before_action :authenticate_patient!

  def new
    @appointment = Appointment.new
    @patients = Patient.all
    @patient = Patient.find(params[:patient_id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
       redirect_to public_appointment_path(@appointment), notice: "予約依頼が完了しました"
    else
       @patient = Patient.find(params[:appointment][:patient_id])
       flash.now[:alert] = "予約依頼が失敗しました"
       render "new"
    end
  end

  def index
    patient = current_patient
    @appointments = patient.appointments.page(params[:page]).order(created_at: :desc)
    @patient = Patient.find(params[:format])
  end

  def show
    @appointment = Appointment.find(params[:id])
    @patient = Patient.find(@appointment.patient_id)
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_update_params)
      redirect_to public_appointment_path(@appointment), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
      render :edit
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id,
      :appointment_date,
      :remark,
      :symptom_text,
      :status,
      :charge_id,
      :subscriber_id,
      { symptom_ids: []},
      { treatment_ids: []},)
  end

  def appointment_update_params
    params.require(:appointment).permit(:patient_id,
      :appointment_date,
      :charge_id,
      :remark,
      :status,
      :symptom_text,
      :visit_date,
      :subscriber_id,
      { symptom_ids: []},
      { treatment_ids: []})
  end
end
