class Appointment < ApplicationRecord
  belongs_to :patient
  # belongs_to :employee, class_name: 'Employee', foreign_key: :charge_id

  belongs_to :charge, class_name: 'Employee', foreign_key: :charge_id, optional: true
  belongs_to :subscriber, class_name: 'Employee', foreign_key: :subscriber_id, optional: true

  has_many :appointment_symptoms
  has_many :symptoms, through: :appointment_symptoms
  has_many :appointment_treatments
  has_many :treatments, through: :appointment_treatments

  enum status: { confirm: 0, cancel: 1, visit: 2 }

  def self.appointments_list(day)
    self.where(appointment_date: Date.parse(day).beginning_of_day...Date.parse(day).end_of_day)
  end

end
