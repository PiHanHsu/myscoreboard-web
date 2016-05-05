class AddTeamsCoulumnType < ActiveRecord::Migration
  def change
    add_column :teams, :location_id, :integer, :index => true
    change_column :locations, :place_name, :string, :default => ""
  end
end
