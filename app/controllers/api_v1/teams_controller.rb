class ApiV1::TeamsController < ApiController
  protect_from_forgery :except => [:create, :update, :edit, :add_team_member ]
  before_action :authenticate_user!
  before_action :set_team_params, :only => [:update, :edit]

  def index
    @teams = current_user.teams.all
  end

  def create
    # @location = Location.find_or_create_by(:place_name => params[:place_name])
    @location = Location.find_or_create_by(:place_name => params[:place_name],
                                           :address => params[:address],
                                           :lat => params[:lat],
                                           :lng => params[:lng])
    # params[:team][:location_id] = @location.id

    @team = current_user.teams.create(:name => params[:name],
                                      :day => params[:day],
                                      :start_time => params[:start_time],
                                      :end_time => params[:end_time],
                                      :logo => params[:logo],
                                      :location_id => @location.id
                                      )


    if @team
      render json: {
        message: "儲存成功",
      }
    else
      render json: {
        message: "儲存失敗",
      }, status: 400
    end
  end

  def edit
    @team = set_team_params
  end

  def update
    team = set_team_params
    @team = team.update( :name => params[:name],
                         :day => params[:day],
                         :start_time => params[:start_time],
                         :end_time => params[:end_time],
                         :logo => params[:logo])
                          #todo：location
                          #todo:思考是否需要新增單獨的加好友API
    #  params[:user_ids] #=> [1,2,3,...]
    if params[:added_user_ids]
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

    if @team || @userteamship
     render json: {
     message: "更新成功" }
    end
  end

  def add_team_member
    params[:user_ids].each do |user_id|
      UserTeamship.create(:user_id => user_id, :team_id => params[:id])
    end
      render json: {
      message: "新增成功",
       }
  end


  private


  def set_team_params
    @team = current_user.teams.find( params[:id] )
  end

  # def team_params
  #   params.require(:team).permit(:name, :day, :start_time, :end_time, :logo)
  # end
  #
  # def location_params
  #   params.require(:location).permit(:place_name, :address, :lat, :lng,)
  # end

end
