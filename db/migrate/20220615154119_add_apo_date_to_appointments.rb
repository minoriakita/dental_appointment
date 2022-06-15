class AddApoDateToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :apo_date, :date
  end
end
