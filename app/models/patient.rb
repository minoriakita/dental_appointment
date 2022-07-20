class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :authentication_keys => [:telephone_number]

  has_many :appointments
  has_many :patient_infections
  has_many :infections, through: :patient_infections

  validates :password, presence: true, on: :create
  validates :last_name, length: { maximum: 20 }
  validates :first_name, length: { maximum: 20 }
  validates :last_name_kana, presence: true, length: { maximum: 20 },
  format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力してください'}
  validates :first_name_kana, presence: true, length: { maximum: 20 },
  format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力してください'}
  validates :patient_text, length: { maximum: 300 }
  validates :telephone_number, numericality: true, uniqueness: true, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validate :date_after_start

  enum gender: { man: 0, woman: 1, other: 2 }

  def is_visited?(on: Date.today)
    appointments.where("appointment_date < ?", on).where(status: :visit).exists?
  end

  def get_age
    return if birthday.nil?
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def self.search(keyword)
    where([
      "id = ? OR first_name_kana LIKE ? OR last_name_kana LIKE ?",
      "#{keyword}", "%#{keyword}%", "%#{keyword}%"
      ])
  end

  def full_name
    "#{self.last_name} #{self.first_name}"
  end

  def full_name_kana
    "#{self.last_name_kana} #{self.first_name_kana}"
  end
end

def date_after_start
    return if birthday.blank?
    errors.add(:birthday, "は今日以前のものを選択してください") if birthday > Date.today
end