class AddForeignKeysToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_reference :appointments, :charge, foreign_key: { to_table: :employees }
    add_reference :appointments, :subscriber, foreign_key: { to_table: :employees }
  end
end
