class PublicAppointment < ActiveType::Record[Appointment]
  validates :symptom, presence: true
end
