class TeamUserShipController < ApplicationController

  before_action :authenticate_user!

  def bulk_delete_player

		team_id = params[:team_id]
		ids = Array(params[:team][:user_ids])
		remove_user_teamships = ids.map{|i| UserTeamship.find_by_team_id_and_user_id(team_id, i)}.compact
		if params[:commit] == "確認刪除"
			remove_user_teamships.each{|e| e.destroy}
		end

		redirect_to :back
	end

  def add_player
    @user_teamship = UserTeamship.lock.find_or_create_by( :team_id => params[:id], :user_id => params[:user_id] )
		redirect_to :back
	end





end
