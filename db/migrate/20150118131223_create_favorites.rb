class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :pid
      t.integer :uid

      t.timestamps
    end
  end
end
