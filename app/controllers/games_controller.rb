class GamesController < ApplicationController
  before_action :authenticate_user!
  
	def index
    @teams = current_user.teams

    if params[:team]
      @team = @teams.find(params[:team])
	  else
      @team = @teams.first
    end
  end
end
