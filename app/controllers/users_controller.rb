class UsersController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  before_action :set_user, :only => [ :show, :update, :destroy]


  def index

  @users = User.all

  if params[:search]
    @users = User.where( [ "email like ?", "%#{params[:search]}%" ] )
  else
    @users = User.all
  end

  end

  def show
  end


  def update
  end


  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:id, :user_id )
  end

  def set_user
    @user = User.find(params[:id])
  end


end
