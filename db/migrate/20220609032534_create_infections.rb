class CreateInfections < ActiveRecord::Migration[6.1]
  def change
    create_table :infections do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
