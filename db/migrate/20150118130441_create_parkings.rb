class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :name
      t.string :address
      t.float :lon
      t.float :lat
      t.float :price
      t.integer :total
      t.integer :taken

      t.timestamps
    end
  end
end
