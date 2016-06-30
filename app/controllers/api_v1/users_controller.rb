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

  def reset_password

    if params[:email]
      if User.exists?(email: params[:email])
        @user = User.find_by_email(params[:email])
        @user.send_reset_password_instructions
        render json: { message: "設定密碼信件已寄出" }, :status => 200
      else
        render json: { message: "無此信箱" }, :status => 401
      end
    end

  end

  def new
  end

  def edit
  end

  def create
  end

  def update

    @user.update(user_params)

    if @user.save
      render json: { message: "更新成功" }, :status => 200
    else
      render json: { message: "更新失敗" }, :status => 401
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
    params.permit(:email, :gender, :head, :username, :password)
  end

end

