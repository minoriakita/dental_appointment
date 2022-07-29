class PublicAppointment < ActiveType::Record[Appointment]
  # 患者が予約リクエストする際のバリデーション
  validates :appointment_symptoms, presence: true
end
