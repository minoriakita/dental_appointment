class AppointmentSymptom < ApplicationRecord
  has_many :symptoms
  belongs_to :appointment
end
