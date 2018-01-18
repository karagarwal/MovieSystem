class CreateShowtimes < ActiveRecord::Migration
  def change
    create_table :showtimes do |t|
      t.time :timing
      t.references :movie, foreign_key: true
      t.timestamps
    end
  end
end
