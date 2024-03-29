class Public::AppointmentsController < ApplicationController
   before_action :authenticate_patient!, except: [:day_index, :new]

  def new
    #ログインしていなければログイン画面へ
    unless patient_signed_in?
      return redirect_to new_patient_session_path
    end
    @appointment = PublicAppointment.new
    @patient = current_patient
    @day = Time.parse(params[:date])
  end

  def create
    @appointment = PublicAppointment.new(appointment_params)
    if @appointment.save
       redirect_to public_appointment_path(@appointment), notice: "予約依頼が完了しました"
    else
       @patient = Patient.find(params[:appointment][:patient_id])
       @day = Time.parse(appointment_params[:appointment_date])
       redirect_to new_public_appointment_path(date: appointment_params[:appointment_date]), notice: "予約依頼が失敗しました", flash: { secondary: "・症状を入力してください"}
    end
  end

  def edit
    @appointment = PublicAppointment.find(params[:id])
  end

  def update
    @appointment = PublicAppointment.find(params[:id])
    if @appointment.update(appointment_update_params)
      redirect_to public_appointment_path(@appointment), notice: "変更が完了しました"
    else
      flash.now[:alert] = "変更が失敗しました"
      render :edit
    end
  end

  #詳細ページを見たら通知外す
  def show
    @appointment = PublicAppointment.find(params[:id])
    @patient = @appointment.patient
    if @patient == current_patient &&
      !@appointment.checked? &&
      (@appointment.status_before_type_cast == Appointment.statuses["confirm"] ||
      @appointment.status_before_type_cast == Appointment.statuses["impossible"])
       @appointment.update(checked: true)
    end
  end

  #日付ごとの予約状況
  def day_index
    @day = params[:day]
    today = Date.today
    @today_text = today.strftime("%Y-%m-%d")
  end

  #予約履歴
  def history
    @appointments = current_patient.appointments.page(params[:page]).order(created_at: :desc)
    @patient = Patient.find(params[:id])
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
