class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_user, :only => [:update, :destroy, :show]


  def index

   @users = User.all

    if params[:search]
      @users = User.where( 'email_first LIKE ? OR username LIKE?' , "%#{params[:search]}%", "%#{params[:search]}%" )
    else
      @users = User.all
    end

    respond_to do |format|
    format.html
    format.js
    end

  end

  def show
    @user = current_user
    @card = Card.new
    @cards = @user.cards
  end

  def edit
    @user = current_user
  end

  def update
      @user = current_user

    if @user.update( user_params )
      redirect_to root_path
    else
      render "edit"
    end

  end


  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:id, :user_id, :emial, :username, :userid, :gender )
  end

  def set_user
    @user = User.find(params[:id])
  end


end
