class ChangeTeamsCoulumnType < ActiveRecord::Migration
  def up
    change_column :teams, :location_id, :integeer
    add_column :locations, :google_id, :integeer
  end

  def down
    change_column :teams, :location_id, :integeer, null: true
  end
end
