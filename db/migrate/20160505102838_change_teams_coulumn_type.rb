class ChangeTeamsCoulumnType < ActiveRecord::Migration
  def up
    change_column :teams, :location_id, :integer
    add_column :locations, :google_id, :integer
  end

  def down
    change_column :teams, :location_id, :integer, null: true
  end
end
