class ApiV1::AuthController < ApiController

   before_action :authenticate_user!, :only => [:logout]


    def signup
      success = false
      #POST /api/v1/signup

      if params[:email] && params[:password]

        user = User.new(:email => params[:email], :password => params[:password])
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
                   email: fb_data["email"]
                 },
                 credentials: {
                   token: params[:access_token]
                 }
               })
               user = User.from_omniauth(auth_hash)
             end
           success = fb_data && user.persisted?
         end

        if success
         render :json => { :auth_token => user.authentication_token,
                           :user_id => user.id}, :status => 200
        else
         render :json => { :message => "email or password is not correct" }, :status => 401
        end

    end

    def login
     success = false

     if params[:email] && params[:password]
       user = User.find_by_email( params[:email] )
       success = user && user.valid_password?( params[:password] )

     elsif params[:access_token]
       fb_data = User.get_fb_data( params[:access_token] )
         if fb_data
           auth_hash = OmniAuth::AuthHash.new({
             uid: fb_data["id"],
             info: {
               email: fb_data["email"]
             },
             credentials: {
               token: params[:access_token]
             }
           })
           user = User.from_omniauth(auth_hash)
         end
       success = fb_data && user.persisted?
     end



        if success
         render :json => { :auth_token => user.authentication_token,
                           :user_id => user.id}, :status => 200
        else
         render :json => { :message => "email or password is not correct" }, :status => 401
        end

    end

   def logout
     user = current_user

     user.generate_authentication_token
     user.save!

     render :json => { :message => "ok" }
   end

 end
