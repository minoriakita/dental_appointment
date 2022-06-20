class Treatment < ApplicationRecord
  has_many :appointment_treatments

  validates :name, presence: true, length: { maximum: 20 }

end
