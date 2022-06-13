class Patient < ApplicationRecord
  has_many :appointments
  has_many :patient_infections
  has_many :infections, through: :patient_infections

  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  enum gender: { man: 0, woman: 1, other: 2 }

def age days
 ((days + 0.8)/365.25).to_i
end

end
