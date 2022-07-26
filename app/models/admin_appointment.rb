class AdminAppointment < ActiveType::Record[Appointment]
  validates :charge, presence: true
  validates :subscriber, presence: true
end
