class GamesController < ApplicationController
  before_action :authenticate_user!

	def index

    # 若使用者沒有id 會跳到輸入id的頁面
    if current_user.userid == nil
      redirect_to enteruserid_path
    end
    # 若使用者沒有id 會跳到輸入id的頁面

    @teams = current_user.teams

    if params[:team]
      @team = @teams.find(params[:team])
	  else
      @team = @teams.first
    end

    if @team
      @game_type = "mix"
      if params[:game_type] == "single"
        @game_type = "single"
        @male_ranking = @team.male_single_ranking
        @female_ranking = @team.female_single_ranking
      elsif params[:game_type] == "double"
        @game_type = "double"
        @male_ranking = @team.male_double_ranking
        @female_ranking = @team.female_double_ranking
      else
        @male_ranking = @team.male_mix_ranking
        @female_ranking = @team.female_mix_ranking
      end
    end
  end

  def new
    @game = Game.create( :team_id => params[:team_id])
    @record = Record.new
  end

  def create
  end

end
