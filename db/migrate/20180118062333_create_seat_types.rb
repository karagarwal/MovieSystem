class CreateSeatTypes < ActiveRecord::Migration
  def change
    create_table :seat_types do |t|
      t.string :category
      t.references :audi, foreign_key: true
      t.timestamps
    end
  end
end
