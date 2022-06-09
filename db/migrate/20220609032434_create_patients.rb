class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.date :birthday
      t.integer :gender
      t.string :email
      t.string :postal_code
      t.string :address
      t.string :telephone_number

      t.timestamps
    end
  end
end
