class Appointment < ApplicationRecord
  # scope :publics, -> { where.not(status: ["request", "impossible"]) }

  belongs_to :patient
  belongs_to :charge, class_name: 'Employee', foreign_key: :charge_id, optional: true
  belongs_to :subscriber, class_name: 'Employee', foreign_key: :subscriber_id, optional: true

  has_many :appointment_symptoms
  has_many :symptoms, through: :appointment_symptoms
  has_many :appointment_treatments
  has_many :treatments, through: :appointment_treatments

  validates :remark, length: { maximum: 300 }
  validates :symptom_text, length: { maximum: 300 }
  validates :appointment_date, presence: true
  validate :date_before_start, on: :create
  validate :start_finish_check

  enum status: { confirm: 0, cancel: 1, visit: 2, request: 3, impossible: 4 }

  #一日のアポイント件数を表示
  def self.appointments_list(day)
    self.where(appointment_date: Date.parse(day).beginning_of_day...Date.parse(day).end_of_day, status: ["confirm", "visit"])
  end

  def self.appointments_possible?(day, from, to)
    #確定と来院済みのものだけ取得
    from = DateTime.parse("#{day} #{from}")
    to = DateTime.parse("#{day} #{to}")
    self.where(appointment_date: from...to, status: ["confirm", "visit"]).exists?
  end

  #日時バリデーション
  def date_before_start
    return if appointment_date.blank?
    errors.add(:appointment_date, "は今日以降のものを選択してください。") if appointment_date < Date.today
  end

  #時間を数字に変換して時間のバリデーション
  def start_finish_check
    return if appointment_date.blank?
    errors.add(:appointment_date, "は10時から18時30分の間で選択してください") if appointment_date.strftime('%H%M').to_i < 1000 || 1830 < appointment_date.strftime('%H%M').to_i
  end
end