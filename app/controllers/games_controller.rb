class GamesController < ApplicationController
  before_action :authenticate_user!

	def index
    @teams = current_user.teams

    if params[:team]
      @team = @teams.find(params[:team])
	  else
      @team = @teams.first
    end

    @male_records = Record.includes(:user, :game).where( users: { :gender => "male" } ).where( games: { team_id: @team.id } ).where( :result => "W" ).group( :user ).count
    @female_records = Record.includes(:user, :game).where( users: { :gender => "female" } ).where( games: { team_id: @team.id } ).where( :result => "W" ).group( :user ).count

  end
end
