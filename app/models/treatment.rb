class Treatment < ApplicationRecord
  has_many :appointment_treatments

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }

end
