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
      # flash.now[:alert] = "予約依頼が失敗しました"
       redirect_to new_public_appointment_path(date: appointment_params[:appointment_date]), notice: "予約依頼が失敗しました", flash: { secondary: "・症状を入力してください"}#notice: "予約依頼が失敗しました"
    end
  end

  def history
    @appointments = current_patient.appointments.page(params[:page]).order(created_at: :desc)
    @patient = Patient.find(params[:id])
  end

  def show
    @appointment = PublicAppointment.find(params[:id])
    @patient = @appointment.patient
    if @patient == current_patient && !@appointment.checked?
       @appointment.update(checked: true)
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

  def day_index
    @day = params[:day]
    today = Date.today
    @today_text = today.strftime("%Y-%m-%d")
  end

  # def get_checked_count
  #   アドミン側でステータスを変えたものの数を数える
  # 　　@appointment.update(status: "confirm" "impossible").length
  #     @checked_count = Appointment.where(status: "confirm" "impossible")
  # showページ見たらtrueになる
  # @appointment.update(checked: "true")
  #   end
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
