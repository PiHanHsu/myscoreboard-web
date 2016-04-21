class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :place_name
      t.string :address
      t.string :lat
      t.string :lng
      

      t.timestamps null: false
    end
  end
end
