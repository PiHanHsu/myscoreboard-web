class Team < ActiveRecord::Base
  belongs_to :location
  has_many :user_teamships
  has_many :users, :through => :user_teamships

end
