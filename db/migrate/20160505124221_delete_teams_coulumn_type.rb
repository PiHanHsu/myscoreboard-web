class DeleteTeamsCoulumnType < ActiveRecord::Migration
  def change
    remove_column :teams, :location_id
  end
end
