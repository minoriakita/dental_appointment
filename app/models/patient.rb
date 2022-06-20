class Patient < ApplicationRecord
  has_many :appointments
  has_many :patient_infections
  has_many :infections, through: :patient_infections

  validates :last_name, length: { maximum: 20 }
  validates :first_name, length: { maximum: 20 }
  validates :last_name_kana, presence: true, length: { maximum: 20 }
  validates :first_name_kana, presence: true, length: { maximum: 20 }
  validates :patient_text, length: { maximum: 300 }
  validates :postal_code, numericality: true, allow_blank: true
  validates :telephone_number, numericality: true, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, allow_blank: true

  enum gender: { man: 0, woman: 1, other: 2 }

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
