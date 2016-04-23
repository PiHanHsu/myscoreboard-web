class ApiV1::TeamsController < ApplicationController
  protect_from_forgery except: :create
  # before_action :test_set_user

  def index
    @user = User.first
    @teams = @User.teams
  end


  def create
    @user = User.first
    @team = @user.teams.new( :name => params[:name],
                             :day => params[:day],
                             :start_time => params[:start_time],
                             :end_time => params[:end_time],
                            #  :logo => params[:logo]
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


  # private
  #
  #   def team_params
  #     params.require(:v1_team).permit(:name, :day, :start_time, :end_time , :logo)
  #   end

    # def test_set_user
    #   current_user = User.first
    # end
end
