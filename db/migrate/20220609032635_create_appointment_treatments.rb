class CreateAppointmentTreatments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_treatments do |t|
      t.integer :treatment_id, null: false
      t.integer :appointment_id, null: false

      t.timestamps
    end
  end
end
