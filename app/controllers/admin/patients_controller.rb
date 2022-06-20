class Admin::PatientsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @patient = Patient.new
    @infection = Infection.all
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to admin_patient_path(@patient.id)
    else
      render "new"
    end
  end

  def index
    @patients = Patient.all
  end

  def search
    @patients = Patient.search(params[:keyword])
    @keyword = params[:keyword]
  end

  def show
    @patient = Patient.find(params[:id])
    @patient_infection = PatientInfection.find_by(patient_id: params[:id])
    if @patient_infection != nil
       @infection = Infection.find(@patient_infection.infection_id)
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
       redirect_to admin_patient_path(@patient)
    else
       render :edit
    end
  end

  def appointment_index
    @patient = Patient.find(params[:patient_id])
    @appointments = @patient.appointments.all.order(created_at: :desc)
  end

  def destroy
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
    { infection_ids: []})
  end
end
