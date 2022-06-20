class Symptom < ApplicationRecord
  has_many :appointment_symptoms

  validates :name, presence: true, length: { maximum: 20 }
end
