class Infection < ApplicationRecord
  has_many :patient_infections

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }

end
