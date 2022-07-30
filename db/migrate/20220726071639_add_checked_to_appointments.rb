class AddCheckedToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :checked, :boolean, default: false, null: false
  end
end
