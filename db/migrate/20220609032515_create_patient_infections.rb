class CreatePatientInfections < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_infections do |t|
     t.integer :infection_id, null: false
     t.integer :patient_id, null: false

      t.timestamps
    end
  end
end
