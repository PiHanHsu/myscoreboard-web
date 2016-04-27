class ApiV1::TeamsController < ApiController
  protect_from_forgery :except => [:create, :update, :edit]
  before_action :authenticate_user!
  before_action :set_team_params, :only => [:update, :edit]

  def index
    @teams = current_user.teams.all.page(params[:page])
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
        status: 200
      }
    else
      render json: {
        message: "儲存失敗",
        status: 400
      }
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
                         :logo => params[:logo]
                          )
    #  params[:user_ids] #=> [1,2,3,...]
     params[:user_ids][:added].each do |id|
       UserTeamship.create(:user_id => id, :team_id => @team)
     end
     UserTeamship.where(:id => params[:user_ids][:removed]).destroy_all
     #  UserTeamships.create(:user_id => params[:user_ids], :team_id => @team)
     render json: {
     message: "更新成功",
     status: 200  }

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
