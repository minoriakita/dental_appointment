class Infection < ApplicationRecord
  has_many :patient_infections

  validates :name, presence: true, length: { maximum: 20 }

end
