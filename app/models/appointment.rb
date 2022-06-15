class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :employee, class_name: 'Employee', foreign_key: :charge_id
  has_many :appointment_symptoms
  has_many :symptoms, through: :appointment_symptoms
  has_many :appointment_treatments
  has_many :treatments, through: :appointment_treatments

  enum status: { confirm: 0, visit: 1, cancel: 2 }

end
