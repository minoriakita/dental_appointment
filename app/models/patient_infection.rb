class PatientInfection < ApplicationRecord
  belongs_to :patient
  belongs_to :infection
end
