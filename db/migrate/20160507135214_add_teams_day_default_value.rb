class AddTeamsDayDefaultValue < ActiveRecord::Migration
  def change
    change_column :teams, :day, :string, :default => ""
  end
end
