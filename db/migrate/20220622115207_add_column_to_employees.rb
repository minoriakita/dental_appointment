class AddColumnToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :is_deleted, :boolean, default: false
  end
end
