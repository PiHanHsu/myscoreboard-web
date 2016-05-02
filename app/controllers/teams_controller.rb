class TeamsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  def index
     @users = User.all

    if params[:search]
      @users = User.where( 'email_first LIKE ? OR username LIKE?' , "%#{params[:search]}%", "%#{params[:search]}%" )
    else
      @users = User.all
    end
    # render(:index)
	end


end
