class TeamsController < ApplicationController

	protect_from_forgery :except => [:create, :update, :edit, :add_team_member ]
  before_action :authenticate_user!
  before_action :set_team, :only => [:update, :edit]

  def index

    # 若使用者沒有id 會跳到輸入id的頁面
    # if current_user.userid == nil
    #   redirect_to enteruserid_path
    # end
    # 若使用者沒有id 會跳到輸入id的頁面

    @teams = current_user.teams
		@team = Team.new
		@team.build_location
		# @team.location_id=@location.id
    @user = current_user

    if params[:team]
      @team_tab = Team.find( params[:team] )
    else
      @team_tab = @teams.first
    end
  end

  def create
    # @location = Location.find_or_create_by(:place_name => params[:place_name])
		location = Location.find_or_create_by(:place_name => params[:team][:location][:place_name])
		team = current_user.teams.create!(team_params)
		team.location = location
		# team.location = location
    if team.save
      redirect_to teams_path
    else
			render :action => :create
    end
  end

  def edit
  end

  def update
    location = Location.find_or_create_by(:place_name => params[:team][:location][:place_name])
    # params[:location_id] = @location.id
		@team.location = location
    @team.update_attributes!(team_params)

    #  params[:user_ids] #=> [], nil, [1,2,3,...]
    if params[:added_user_ids].present?
      params[:added_user_ids].each do |user_id|
        @userteamship = UserTeamship.create( :user_id => user_id, :team_id => params[:id] )
        #  params[:user_ids][:added].each do |id|
        #  UserTeamships.create(:user_id => params[:user_ids], :team_id => @team)
        #  UserTeamship.create(:user_id => id, :team_id => @team)
        #  end
      end
    end

    if params[:removed_user_ids]
        @userteamship = UserTeamship.where( :user_id => params[:removed_user_ids] ).destroy_all
          # UserTeamship.where(:id => params[:user_ids][:removed]).destroy_all
    end

    if @team.save
      redirect_to teams_path
    else
      render :action => :update
    end
  end

	def bulk_update
		team_id = params[:team_id]
		ids = Array(params[:team][:user_ids])
		remove_user_teamships = ids.map{|i| UserTeamship.find_by_team_id_and_user_id(team_id, i)}.compact
		if params[:commit] == "確認刪除"
			remove_user_teamships.each{|e| e.destroy}
		end

		redirect_to :back
	end

  def add_player
    @user_teamship = UserTeamship.create( :team_id => params[:id], :user_id => params[:user_id] )
    redirect_to :back
	end


  private


  def set_team
    @team = current_user.teams.find( params[:id] )
  end

  # def location_params
  #   params.require(:team).permit(location_attributes:[:place_name])
  # end

  def team_params
    params.require(:team).permit(:name, :day, :start_time, :end_time, :logo, :locaiton_id)
  end

end
