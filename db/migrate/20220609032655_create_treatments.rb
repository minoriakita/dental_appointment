class CreateTreatments < ActiveRecord::Migration[6.1]
  def change
    create_table :treatments do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
