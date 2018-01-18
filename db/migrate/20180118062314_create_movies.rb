class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :rating
      t.decimal :duration
      t.string :language
      t.references :theater, foreign_key: true
      t.references :audi, foreign_key: true
      t.timestamps
    end
  end
end
