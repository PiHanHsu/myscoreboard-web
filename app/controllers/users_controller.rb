class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_user, :only => [:update, :destroy, :show]


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
    @user = User.find_by(:id => params[:id]) # => User instance or nil
    # @user = User.find(params[:id]) # => User instance or 例外
    redirect_to '/' unless @user == current_user
  end

  def update

    @user = current_user

    if @user.update( user_params )
      redirect_to :back
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
      @users = User.all
    else
      @users = User.where( 'email_first LIKE ? OR username LIKE?' , "%#{params[:search]}%", "%#{params[:search]}%" )
    end

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
