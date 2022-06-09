class CreateAppointmentSymptoms < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_symptoms do |t|
      t.integer :appointment_id, null: false
      t.integer :symptom_id, null: false

      t.timestamps
    end
  end
end
