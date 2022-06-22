class RemoveApoDateFromAppointments < ActiveRecord::Migration[6.1]
  def change
    remove_column :appointments, :apo_date, :date
  end
end
