class AppointmentTreatment < ApplicationRecord
  belongs_to :appointment
  has_many :treatments
end
