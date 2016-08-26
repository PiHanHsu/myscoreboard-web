class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_user, :only => [:edit, :update, :destroy, :show]


  def index
   @users = User.all
  end

  def show

    # 若使用者沒有id 會跳到輸入id的頁面
    # if current_user.userid == nil
    #   redirect_to enteruserid_path
    # end
    # 若使用者沒有id 會跳到輸入id的頁面

    #產生新球員卡用
    #@card = Card.new
    # 撈球員卡用
    #@cards = current_user.cards

    @teams = current_user.teams
    
    if params[:team]
      @team_tab = Team.find(params[:team])
    else
      @team_tab = current_user.teams.first
    end
    
    if @team_tab.present?

      @team_games = current_user.records.joins(:game).where( games: { team_id: @team_tab.id } )
    
    end

    if @team_games.present?

      @records = @team_tab.last_2_games(current_user)
      
      @team_record1 = @records[0]
      @userrecord1 = @team_record1[:game]

      @userdata1 = @userrecord1[0]
      @username1 = @userdata1[:username]
      @score1 = @userdata1[:score]
      @user1 =@userdata1[:user]

      @userdata2 = @userrecord1[1]
      @username2 = @userdata2[:username]
      @score2 = @userdata2[:score]
      @user2 =@userdata2[:user]


      @userdata3 = @userrecord1[2]
      @username3 = @userdata3[:username]
      @score3 = @userdata3[:score]
      @user3 =@userdata3[:user]

      @userdata4 = @userrecord1[3]
      @username4 = @userdata4[:username]
      @score4 = @userdata4[:score]
      @user4 =@userdata4[:user]

      @team_record2 = @records[1]
      @userrecord2 = @team_record2[:game]

      @userdata5 = @userrecord2[0]
      @username5 = @userdata5[:username]
      @score5 = @userdata5[:score]
      @user5 =@userdata5[:user]

      @userdata6 = @userrecord2[1]
      @username6 = @userdata6[:username]
      @score6 = @userdata6[:score]
      @user6 =@userdata6[:user]


      @userdata7 = @userrecord2[2]
      @username7 = @userdata7[:username]
      @score7 = @userdata7[:score]
      @user7 =@userdata7[:user]

      @userdata8 = @userrecord2[3]
      @username8 = @userdata8[:username]
      @score8 = @userdata8[:score]
      @user8 =@userdata8[:user]

      @best_double_partner, @best_mix_partner = get_best_partners(@team_tab)
      @games, @win_rate = @team_tab.get_games_win_rate(current_user)
    
    end
     
  end

  def edit
    redirect_to '/' unless @user == current_user

  end

  def update
    if params[:user] && @user == current_user && current_user.update( user_params )
      redirect_to user_path(current_user)
    else
      redirect_to :back
    end
  end

  def create
  @user = User.create(user_params)
  end


  def destroy
  end

  def search

    if params[:search] == ''
      @users = nil
    else
      @users = User.where( 'email_first LIKE? OR username LIKE? OR userid LIKE?' ,
       "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").limit(10)
    end
    @team = Team.find( params[:team_id])
    return render(:search_fail) unless @users.present?
  end

    def get_best_partners(team)

      if current_user.gender == "male"
        double_teammates = team.users.where( :gender => "male" )
        mix_teammates = team.users.where( :gender => "female" )
      else
        double_teammates = team.users.where( :gender => "female" )
        mix_teammates = team.users.where( :gender => "male" )
      end

      #double_teammates.drop(current_user)

      double_teammates_standing = calculate_partner_standing(double_teammates)
      mix_teammates_standing = calculate_partner_standing(mix_teammates)

      return double_teammates_standing[0], mix_teammates_standing[0]

    end

    def calculate_partner_standing(teammates)

      user_win_games = current_user.records.where( result: "W").joins(:game).where( games: { team_id: params[:team_id] } ).pluck( :game_id )
      wins_with_teammates = Record.where( game_id: user_win_games ).where( :result => "L" ).group(:user).count

      user_loss_games = current_user.records.where( result: "L").joins(:game).where( games: { team_id: params[:team_id] } ).pluck( :game_id )
      losses_with_teammates = Record.where( game_id: user_loss_games ).where( :result => "W" ).group(:user).count

      teammates.map do |teammate|
        wins = 0
        losses = 0
        if wins_with_teammates[teammate]
          wins = wins_with_teammates[teammate]
        end
        if losses_with_teammates[teammate]
          losses = losses_with_teammates[teammate]
        end
        rate = wins.to_f / (wins.to_f + losses.to_f)
        {user: teammate,
         wins: wins,
         losses: losses,
         rate: rate.round(2)}
      end

      teammates = teammates.sort {|a, b| b[:rate] <=> a[:rate] }
    end

  private

  def user_params
    params.require(:user).permit(:id, :user_id, :emial, :username, :userid, :gender, :head )
  end

  def set_user
    @user = User.find(params[:id])
  end


end
