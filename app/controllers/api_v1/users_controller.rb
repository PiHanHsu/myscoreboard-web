class ApiV1::UsersController < ApiController

  before_action :authenticate_user!

  before_action :set_user, :only => [ :show, :update, :destroy]

  def show
  end


  def update
  end


  def destroy
  end


  def search

    if params[:search]

      @users = User.where( 'email_first LIKE? OR username LIKE? OR userid LIKE?' ,
       "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").limit(10)

    else
      render :json => { :message => "Fail! " }, :status => 401
    end
  end



  private

  def set_user
    @user = User.find(params[:id])
  end


end

