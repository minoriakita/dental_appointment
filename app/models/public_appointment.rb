class PublicAppointment < ActiveType::Record[Appointment]
  validates :appointment_symptoms, presence: true
end
