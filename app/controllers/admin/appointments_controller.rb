class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @appointment = AdminAppointment.new
    @patients = Patient.all
    @patient = Patient.find(params[:patient_id])
  end

  def create
    @appointment = AdminAppointment.new(appointment_params)
    if @appointment.save
       redirect_to admin_appointment_path(@appointment), notice: "予約が完了しました"
    else
       @patient = Patient.find(params[:appointment][:patient_id])
       flash.now[:alert] = "予約が失敗しました"
       render "new"
    end
  end

  def index
    @employees = Employee.all
    @day = params[:day]
    if @day.blank?
      redirect_to admin_appointments_path(day: Date.current.strftime('%Y-%m-%d'))
    end
  end

  def show
    @appointment = AdminAppointment.find(params[:id])
  end

  def edit
    @appointment = AdminAppointment.find(params[:id])
  end

  def update
    @appointment = AdminAppointment.find(params[:id])
    $request_count = Appointment.where(status: "request").length
    if @appointment.update(appointment_update_params)
      # ステータスがcancelになったら来院日削除
      @appointment.update(visit_date: nil) if @appointment.status == 'cancel'
      redirect_to admin_appointment_path(@appointment), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
      render :edit
    end
  end

  #来院ステータスに変更
  def visit_date
    @appointment = AdminAppointment.find(params[:id])
    @appointment.update(
        visit_date: Time.current,
        status: 2
      )
    flash.now[:notice] = "来院しました"
  end

  #リクエストステータス一覧
  def request_index
    @appointments = AdminAppointment.where(status: "request").page(params[:page])
  end

  # def appointment_impossible
  #   @appointment = AdminAppointment.find(params[:appointment_id])
  #   @appointment.update!(
  #       status: 4
  #     )
  #   $request_count = Appointment.where(status: "request").length
  #   redirect_to admin_appointment_path(@appointment.id)
  # end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id,
      :appointment_date,
      :remark,
      :symptom_text,
      :status,
      :charge_id,
      :subscriber_id,
      :checked,
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
      :checked,
      { symptom_ids: []},
      { treatment_ids: []})
  end
end
