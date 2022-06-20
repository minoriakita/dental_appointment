class Appointment < ApplicationRecord
  belongs_to :patient
  # belongs_to :employee, class_name: 'Employee', foreign_key: :charge_id

  belongs_to :charge, class_name: 'Employee', foreign_key: :charge_id, optional: true
  belongs_to :subscriber, class_name: 'Employee', foreign_key: :subscriber_id, optional: true

  has_many :appointment_symptoms
  has_many :symptoms, through: :appointment_symptoms
  has_many :appointment_treatments
  has_many :treatments, through: :appointment_treatments

  validates :appointment_date, presence: true
  validate :date_before_start
  validates :charge, presence: true
  validates :remark, length: { maximum: 300 }
  validates :symptom_text, length: { maximum: 300 }
  validates :subscriber, presence: true

  enum status: { confirm: 0, cancel: 1, visit: 2 }

  def self.appointments_list(day)
    self.where(appointment_date: Date.parse(day).beginning_of_day...Date.parse(day).end_of_day)
  end

  def date_before_start
    return if appointment_date.blank?
    errors.add(:appointment_date, "は今日以降のものを選択してください") if appointment_date < Date.today
  end

end
