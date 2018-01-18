class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :seat_number
      t.decimal :price
      t.references :showtime, foreign_key: true
      t.references :audi, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :seat_type, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
