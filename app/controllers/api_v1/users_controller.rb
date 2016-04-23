class ApiV1::UsersController < ApiController

  before_action :authenticate_user!

  before_action :set_user, :only => [ :show, :update, :destroy]

  def show
  end


  def update
  end


  def destroy
  end


  private

  def set_user
    @user = User.find(params[:id])
  end


end
