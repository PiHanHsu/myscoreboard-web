module TeamsHelper
  def team_weekday_options
    Team::DAY.map do |day|
      [day]
    end
  end


end
