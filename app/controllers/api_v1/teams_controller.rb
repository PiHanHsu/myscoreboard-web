class ApiV1::TeamsController < ApiController
  protect_from_forgery :except => [:create, :update]
  # before_action :test_set_user
  # before_action :set_user
  before_action :authenticate_user!
  before_action :set_team_params, :only => [:update]

  def index
    @teams = current_user.teams.all
  end


  def create
    @team = current_user.teams.new( :name => params[:name],
                             :day => params[:day],
                             :start_time => params[:start_time],
                             :end_time => params[:end_time],
                             :logo => params[:logo]
                             )
    if @team.save
      render json: {
      message: "儲存成功",
      status: 200  }
    else
      render json: {
      message: "儲存失敗",
      status: 400  }
    end
  end

  def update
    team = set_team_params
    @team = team.update( :name => params[:name],
                         :day => params[:day],
                         :start_time => params[:start_time],
                         :end_time => params[:end_time],
                         :logo => params[:logo]
                          )
     render json: {
     message: "更新成功",
     status: 200  }

  end




  private

  # def set_user
  #   @user = User.first
  # end

  def set_team_params
    @team = current_user.teams.find( params[:id] )
  end



end
