class ChangeColumnToPatient < ActiveRecord::Migration[6.1]
  def change
    remove_index :patients, :email
  end
end
