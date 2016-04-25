class ChangeTeamDatetimeType < ActiveRecord::Migration
  def change
    change_column :teams, :day, :date
    change_column :teams, :start_time, :time
    change_column :teams, :end_time, :time
  end
end
