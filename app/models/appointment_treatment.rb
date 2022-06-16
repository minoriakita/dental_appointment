class AppointmentTreatment < ApplicationRecord
  belongs_to :appointment
  belongs_to :treatment
end
