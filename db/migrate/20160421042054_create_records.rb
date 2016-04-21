class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|

      t.integer :game_id, :index => true
      t.integer :user_id, :index => true
      t.string :result
      t.integer :score

      t.timestamps null: false
    end
  end
end
