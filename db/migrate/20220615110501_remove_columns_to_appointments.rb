class RemoveColumnsToAppointments < ActiveRecord::Migration[6.1]
  def change
    remove_column :appointments, :subscriber_id, :integer
    remove_column :appointments, :charge_id, :integer
  end
end
