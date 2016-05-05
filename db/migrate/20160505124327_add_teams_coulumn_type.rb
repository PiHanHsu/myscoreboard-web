class AddTeamsCoulumnType < ActiveRecord::Migration
  def change
    add_column :teams, :location_id, :integer, :index => true
  end
end
