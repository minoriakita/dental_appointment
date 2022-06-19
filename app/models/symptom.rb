class Symptom < ApplicationRecord
  has_many :appointment_symptoms
  
  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
end
