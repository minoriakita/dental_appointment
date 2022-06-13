class Admin::AppointmentsController < ApplicationController
  def new
    @appointment_form = AppointmentForm.new
    @patients = Patient.all
    @symptoms = Symptom.all
    @treatments = Treatment.all
  end

  def create
    appointment_form = AppointmentForm.new(appointment_form_params)
    appointment_id = appointment_form.save
    redirect_to admin_appointment_path(appointment_id)
  end

  def index
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
     @patient = Patient.find(@appointment.patient_id)
     @symptoms = Symptom.all
     @treatments = Treatment.all
     @appointment_symptom = AppointmentSymptom.find_by(appointment_id: params[:id])
    if @appointment_symptom != nil
      @symptom = Symptom.find(@appointment_symptom.symptom_id)
    end
    @appointment_treatment = AppointmentTreatment.find_by(appointment_id: params[:id])
    if @appointment_treatment != nil
      @treatment = Treatment.find(@appointment_treatment.treatment_id)
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_form_params)
    redirect_to admin_appointment_path(@appointment)
  end

  def destroy
  end

  private

  def appointment_form_params
    params.require(:appointment_form).permit(:patient_id, :appointment_date, :visit_date, :remark, :status, :symptom_text, :treatment_id, :symptom_id)
  end
end
