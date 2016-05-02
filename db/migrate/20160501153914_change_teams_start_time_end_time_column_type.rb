class ChangeTeamsStartTimeEndTimeColumnType < ActiveRecord::Migration

  def up
    change_column :teams, :start_time, :time, :default => "00:00"
    change_column :teams, :end_time, :time, :default => "00:00"
  end
end
