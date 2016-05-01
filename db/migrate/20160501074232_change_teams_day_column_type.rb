class ChangeTeamsDayColumnType < ActiveRecord::Migration
  def change
    change_column :teams, :day, :string
  end
end
