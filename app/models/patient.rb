class Patient < ApplicationRecord
  has_many :appointments
  has_many :patient_infections
  has_many :infections, through: :patient_infections

  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  enum gender: { man: 0, woman: 1, other: 2 }

  def get_age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - self.birthday.strftime(date_format).to_i) / 10000
  end

end
