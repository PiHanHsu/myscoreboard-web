class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :day
      t.time :start_time
      t.time :end_time
      t.attachment :logo
      t.integer :location_id, :index => true,  null: false

      t.timestamps null: false
    end
  end
end
