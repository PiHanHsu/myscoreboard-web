class CreateUserTeamships < ActiveRecord::Migration
  def change
    create_table :user_teamships do |t|
      t.integer :user_id, :index => true,  null: false
      t.integer :team_id, :index => true,  null: false

      t.timestamps null: false
    end
  end
end
