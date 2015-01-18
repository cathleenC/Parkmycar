class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :pid
      t.integer :uid
      t.datetime :time

      t.timestamps
    end
  end
end
