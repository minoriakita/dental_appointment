class Admin::PatientsController < ApplicationController
  
  def new
    @patient = Patient.new
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def patient_params
    params.require(:patient).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, :gender, :email, :postal_code, :address, :telephone_number)
  end
end
