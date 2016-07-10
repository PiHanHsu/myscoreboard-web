class ApiV1::TeamsController < ApiController
  protect_from_forgery :except => [:create, :update, :edit, :add_team_member ]
  before_action :authenticate_user!
  before_action :set_team, :only => [:update, :edit]

  def index
    @teams = current_user.teams
      @teams.each do |team|
        team.users.each do |user|
          user.photo = user.get_photo_url
        end
      end

  end

  def create
    # @location = Location.find_or_create_by(:place_name => params[:place_name])
    location = Location.find_or_create_by(location_params)
    @team = current_user.teams.create(team_params)
    @team.location = location

    #重構
    #@team = current_user.build_team( team_params, location_params )
    #class User < ActiveRecord::Base
    #def build_team( team_attrs, location_attrs)
    #  location = Location.find_or_create_by(location_attrs)
    #  team = self.teams.new(team_attrs)
    #  team.location = location
    #  return team
    #end

    if @team.save
      render json: {
        message: "儲存成功",
        team_id: @team.id
      }
    else
      render json: {
        message: "儲存失敗",
      }, status: 400
    end
  end

  def edit
  end

  def update
    location = Location.find_or_create_by(location_params)
    # params[:location_id] = @location.id
    @team.update(team_params)
    @team.location = location

    #  params[:user_ids] #=> [], nil, [1,2,3,...]
    if params[:added_user_ids].present?
      params[:added_user_ids].each do |user_id|
        @userteamship = UserTeamship.lock.find_or_create_by( :user_id => user_id, :team_id => params[:id] )
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
      render json: { message: "更新成功" }
    else
      render json: { message: "更新失敗" }, :status => 400
    end

  end

  private


  def set_team
    @team = current_user.teams.find( params[:id] )
  end

  def location_params
    params.permit(:place_name, :address, :lat, :lng, :google_place_id)
  end

  def team_params
    params.permit(:name, :day, :start_time, :end_time, :logo)
  end

  # def team_params
  #   params.require(:team).permit(:name, :day, :start_time, :end_time, :logo)
  # end



end
