class Appointment < ApplicationRecord
  belongs_to :patient
  has_many :appointment_symptoms
  has_many :symptoms, through: :appointment_symptoms
  has_many :appointment_treatments
  has_many :treatments, through: :appointment_treatments
end
