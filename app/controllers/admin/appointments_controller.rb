class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @appointment = Appointment.new
    @patients = Patient.all
    @patient = Patient.find(params[:patient_id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
       redirect_to admin_appointment_path(@appointment)
    else
       @patient = Patient.find(params[:appointment][:patient_id])
       render "new"
    end
  end

  def index
    @appointments = Appointment.where(appointment_date: Date.today.beginning_of_day...Date.today.end_of_day)
    @employees = Employee.all
    @day = params[:day]
    if @day.blank?
      redirect_to admin_appointments_path(day: Date.current.strftime('%Y-%m-%d'))
    end
    #@patient = Patient.find(params[:patient_id])
    #Appointment.where(担当者: 佐藤)
    #Appointment.where(担当者: 佐藤).where(日付: today)
  end

  def show
    @appointment = Appointment.find(params[:id])
    @patient = Patient.find(@appointment.patient_id)
    @appointment_symptom = AppointmentSymptom.find_by(appointment_id: params[:id])
    if @appointment_symptom != nil
      @symptom = Symptom.find(@appointment_symptom.symptom_id)
    end
    @appointment_treatment = AppointmentTreatment.find_by(appointment_id: params[:id])
    if @appointment_treatment != nil
      @treatment = Treatment.find(@appointment_treatment.treatment_id)
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_update_params)
      redirect_to admin_appointment_path(@appointment)
    else
      render :edit
    end
  end

  def destroy
  end

  def visit_date
    appointment = Appointment.find(params[:id])
    appointment.update(
        visit_date: Date.today,
        status: 2
      )
    #   if 来院カラムに値が入ったら == ""
    #     @appointment.update_all("status = 1")
    #   end
    # flash[:notice] = "来院しました"
    redirect_to request.referer
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id,
      :appointment_date,
      :remark,
      :symptom_text,
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
