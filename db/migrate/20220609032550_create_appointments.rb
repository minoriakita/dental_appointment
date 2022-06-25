class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.integer :patient_id, null: false
      t.integer :subscriber_id
      t.integer :charge_id
      t.datetime :appointment_date, null: false
      t.date :visit_date
      t.text :remark
      t.integer :status
      t.text :symptom_text
      t.integer :consultation

      t.timestamps
    end
  end
end
