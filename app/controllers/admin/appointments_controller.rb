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
       redirect_to admin_appointment_path(@appointment), notice: "予約が完了しました"
    else
       @patient = Patient.find(params[:appointment][:patient_id])
       flash.now[:alert] = "予約が失敗しました"
       render "new"
    end
  end

  def index
    @appointments = Appointment.publics.where(appointment_date: Date.today.beginning_of_day...Date.today.end_of_day)
    @employees = Employee.all
    @day = params[:day]
    if @day.blank?
      redirect_to admin_appointments_path(day: Date.current.strftime('%Y-%m-%d'))
    end
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
      @appointment.update(visit_date: nil) if @appointment.status == 'cancel'
      redirect_to admin_appointment_path(@appointment), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
      render :edit
    end
  end

  def destroy
  end

  def visit_date
    @appointment = Appointment.find(params[:id])
    @appointment.update!(
        visit_date: Time.current,
        status: 2
      )
    flash.now[:notice] = "来院しました"
  end

  def appointment_request
    @appointments = Appointment.where(status: "request")
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
