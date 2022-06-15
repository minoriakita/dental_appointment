class Patient < ApplicationRecord
  has_many :appointments
  has_many :patient_infections
  has_many :infections, through: :patient_infections

  validates :first_name, presence: true, allow_blank: true
  validates :last_name, presence: true, allow_blank: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  enum gender: { man: 0, woman: 1, other: 2 }

  def get_age
    return if birthday.nil?
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  def self.search(keyword)
    where(["id like? OR last_name_kana like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
