class ApiV1::AuthController < ApiController

   before_action :authenticate_user!, :only => [:logout]

# 註冊
def signup
  success = false
  #POST /api/v1/signup

  if params[:email] && params[:password]

    user = User.new(:email => params[:email], :password => params[:password],
                    :username => params[:username], :gender => params[:gender])

    if params[:head].present?
      data = StringIO.new(Base64.decode64(paramsp[:head]))
      data.class.class_eval {attr_accessor :original_filename, :content_type}
      data.original_filename = self.id.to_s + ".png"
      data.content_type = "image/png"
      user.head = data
    end 

    if user.save
      render :json => { :auth_token => user.authentication_token }, :status => 200
    else
      render :json => {}, :status => 400
    end

  elsif params[:access_token]
    fb_data = User.get_fb_data( params[:access_token] )
      if fb_data
        auth_hash = OmniAuth::AuthHash.new({
          uid: fb_data["id"],
          info: {
            email: fb_data["email"],
            gender: fb_data["gender"],
            name: fb_data["name"],
            picture: fb_data["picture"]
          },
          credentials: {
           token: params[:access_token]
          }
        })
        @user = User.from_omniauth_api(auth_hash)
      end
        success = fb_data && @user.persisted?

        if success
          render :login  # user jbuilder
        else
          render :json => { :message => "email or password is not correct" }, :status => 401
        end
  end
end

# 登入
    def login
     success = false

     if params[:email] && params[:password]
       @user = User.find_by_email( params[:email] )
       success = @user && @user.valid_password?( params[:password] )

     elsif params[:access_token]
       fb_data = User.get_fb_data( params[:access_token] )
         if fb_data
           auth_hash = OmniAuth::AuthHash.new({
             uid: fb_data["id"],
             info: {
                   email: fb_data["email"],
                   gender: fb_data["gender"],
                   name: fb_data["name"],
                   picture: fb_data["picture"]
             },
             credentials: {
               token: params[:access_token]
             }
           })
           @user = User.from_omniauth(auth_hash)
         end
       success = fb_data && user.persisted?
     end

        if success
         # user jbuilder
        else
         render :json => { :message => "email or password is not correct" }, :status => 401
        end

    end

# 登出
   def logout
     user = current_user

     user.generate_authentication_token
     user.save!

     render :json => { :message => "ok" }
   end

 end
