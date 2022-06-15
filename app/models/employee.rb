class Employee < ApplicationRecord
  has_many :appointments, foreign_key: :charge_id
end
