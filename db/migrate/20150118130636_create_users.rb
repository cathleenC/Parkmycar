class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mail
      t.string :plate
      t.string :password

      t.timestamps
    end
  end
end
