class AdminAppointment < ActiveType::Record[Appointment]
  #アドミンでアポイント取得する時のバリデーション
  validates :charge, presence: true
  validates :subscriber, presence: true
end
