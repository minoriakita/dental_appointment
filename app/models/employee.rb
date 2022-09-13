class Employee < ApplicationRecord
  has_many :appointments, foreign_key: :charge_id
  has_many :appointments, foreign_key: :subscriber_id

  validates :name, presence: true, length: { maximum: 20 }

  #employee担当者毎でappointmentのindex表示
  def appointments_list_on_charge(charge_id, day)
    Appointment.where(charge_id: charge_id)
                    .where(appointment_date: Date.parse(day).beginning_of_day...Date.parse(day).end_of_day, status: ["confirm", "cancel", "visit"])
                    .order(appointment_date: "ASC")
  end
end
