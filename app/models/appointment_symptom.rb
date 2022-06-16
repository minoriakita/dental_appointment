class AppointmentSymptom < ApplicationRecord
  belongs_to :symptom
  belongs_to :appointment
end
