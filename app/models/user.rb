class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  before_create :generate_authentication_token

  has_many :user_teamships
  has_many :teams, :through => :user_teamships
  has_many :records
  has_many :cards

  after_create :set_email_first

  # paperclicp
  has_attached_file :head, :styles => { :medium => "300x300#", :thumb => "150x150#" }, :default_url => "default_head.png",
                    :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"
  validates_attachment_content_type :head, content_type: /\Aimage\/.*\Z/

   def generate_authentication_token
     # self.authentication_token = SecureRandom.hex(16)
     self.authentication_token = Devise.friendly_token
   end

    def self.get_fb_data(access_token)

    res = RestClient.get "https://graph.facebook.com/v2.4/me",  { :params => { :fields => "email,name,gender,picture.type(large)", :access_token => access_token } }

      if res.code == 200
        JSON.parse( res.to_str )
      else
        Rails.logger.warn(res.body)
        nil
      end
    end

   def self.from_omniauth(auth)
     # Case 1: Find existing user by facebook uid
     user = User.find_by_fb_uid( auth.uid )
     if user
        user.fb_token = auth.credentials.token
        user.save!
       return user
     end

     # Case 2: Find existing user by email
     existing_user = User.find_by_email( auth.info.email )
     if existing_user
       existing_user.fb_uid = auth.uid
       existing_user.fb_token = auth.credentials.token
       existing_user.save!
       return existing_user
     end

     # Case 3: Create new password
     user = User.new
     user.fb_uid = auth.uid
     user.fb_token = auth.credentials.token
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.fb_raw_data = auth
     user.gender = auth.extra.raw_info.gender
     user.username = auth.info.name
     user.fb_pic = auth.info.image
     user.save!
     return user
    end

  def self.from_omniauth_api(auth)
   # Case 1: Find existing user by facebook uid
   user = User.find_by_fb_uid( auth.uid )
   if user
      user.fb_token = auth.credentials.token
      user.save!
     return user
   end

   # Case 2: Find existing user by email
   existing_user = User.find_by_email( auth.info.email )
   if existing_user
     existing_user.fb_uid = auth.uid
     existing_user.fb_token = auth.credentials.token
     existing_user.save!
     return existing_user
   end

   # Case 3: Create new password
   user = User.new
   user.fb_pic = auth.info.picture.data.url
   user.fb_uid = auth.uid
   user.fb_token = auth.credentials.token
   user.email = auth.info.email
   user.password = Devise.friendly_token[0,20]
   user.fb_raw_data = auth
   user.gender = auth.info.gender
   user.username = auth.info.name

   user.save!
   return user
  end

  protected
 # 當使用者儲存時,產生 email_first, 也產生head
  def set_email_first
    self.email_first = email.split("@").first
    self.save
  end
end
