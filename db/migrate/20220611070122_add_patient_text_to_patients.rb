class AddPatientTextToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :patient_text, :text
  end
end
