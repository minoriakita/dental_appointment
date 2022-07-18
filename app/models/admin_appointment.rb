class AdminAppointment < ActiveType::Record[Appointment]
  validates :charge, presence: true, on: :create
  validates :subscriber, presence: true, on: :create
end
