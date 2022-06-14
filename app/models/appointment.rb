class Appointment < ApplicationRecord
  belongs_to :patient
  has_many :appointment_symptoms
  has_many :symptoms, through: :appointment_symptoms
  has_many :appointment_treatments
  has_many :treatments, through: :appointment_treatments
  
  enum status: { confirm: 0, visit: 1, cancel: 2 }
  
  # def get_age
  #   date_format = "%Y%m%d"
  #   (Date.today.strftime(date_format).to_i - self.birthday.strftime(date_format).to_i) / 10000
  # end
end
