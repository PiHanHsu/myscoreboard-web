class ApiV1::UsersController < ApiController

  # before_action :authenticate_user!

  before_action :set_user, :only => [ :edit, :update, :destroy]


  def show
    if params[:id]
       @user = User.find(params[:id])
    else
       render :json => { :message => "Fail! " }, :status => 401
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update

    if params[:username]
        @user = User.create( :username => @user.username, :gender => @user.gender)
    end

    if @user.save
      render json: "12312123"
    else
      render json: { message: "更新失敗" }, :status => 400
    end
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

  def user_params
    params.permit(:email, :gender, :head)
  end

end

