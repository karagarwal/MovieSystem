class CreateTheaters < ActiveRecord::Migration
  def change
    create_table :theaters do |t|
      t.string :theater_name
      t.string :address
      t.string :phone
      t.timestamps
    end
  end
end
