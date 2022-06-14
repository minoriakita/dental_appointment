class Admin::AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
    @patients = Patient.all
    #@patient = Patient.find_by(patient_id: params[:id])
  end

  def create
    appointment = Appointment.new(appointment_params)
    if appointment.save
       redirect_to admin_appointment_path(appointment)
    else
       render "new"
    end
  end

  def index
    @appointments = Appointment.all
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
    appointment = Appointment.find(params[:id])
    appointment.update(appointment_update_params)
    redirect_to admin_appointment_path(appointment)
  end

  def destroy
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id,
      :appointment_date,
      :charge_id,
      :remark,
      :symptom_text,
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
      { symptom_ids: []},
      { treatment_ids: []},
      :visit_date)
  end
end
