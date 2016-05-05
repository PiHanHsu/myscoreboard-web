class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_user, :only => [:edit, :update, :destroy, :show]


  def index
   @users = User.all
  end

  def show
    #產生新球員卡用
    @card = Card.new
    # 撈球員卡用
    @cards = current_user.cards
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



  private

  def user_params
    params.require(:user).permit(:id, :user_id, :emial, :username, :userid, :gender, :head )
  end

  def set_user
    @user = User.find(params[:id])
  end


end
