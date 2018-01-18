class CreateAudis < ActiveRecord::Migration
  def change
    create_table :audis do |t|
      t.integer :code
      t.integer :number_of_seats
      t.references :theater, foreign_key: true
      t.timestamps
    end
  end
end
