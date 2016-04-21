class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.integer :team_id, :index => true,  null: false
      t.string :game_type

      t.timestamps null: false
    end
  end
end
