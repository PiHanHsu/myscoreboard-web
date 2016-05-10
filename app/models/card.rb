class Card < ActiveRecord::Base

  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "90x150!" }, :default_url => "default_head.png",
                    :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
