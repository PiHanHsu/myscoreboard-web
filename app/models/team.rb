class Team < ActiveRecord::Base
  belongs_to :location
  has_many :games
  has_many :user_teamships
  has_many :users, :through => :user_teamships
  validates_length_of :name, :maximum => 20
  validates_presence_of :name
#  accepts_nested_attributes_for :location

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "200x200>" }, :default_url => "team_logo_dafault.png",
                    :storage => :s3, :s3_protocol => :https, :s3_credentials => "#{Rails.root}/config/s3.yml", :s3_host_name => "s3-ap-northeast-1.amazonaws.com"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  DAY = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日",]


  def male_single_ranking
    records = Record.includes(:user, :game).where( users: { :gender => "male" } ).where( games: { team_id: self.id, game_type: "single" } )
    male_single_ranking = create_ranking(records, "male")
  end

  def female_single_ranking
    records = Record.includes(:user, :game).where( users: { :gender => "female" } ).where( games: { team_id: self.id, game_type: "single" } )
    male_single_ranking = create_ranking(records, "female")
  end

  def male_double_ranking
    records = Record.includes(:user, :game).where( users: { :gender => "male" } ).where( games: { team_id: self.id, game_type: "double" } )
    male_single_ranking = create_ranking(records, "male")
  end

  def female_double_ranking
    records = Record.includes(:user, :game).where( users: { :gender => "female" } ).where( games: { team_id: self.id, game_type: "double" } )
    male_single_ranking = create_ranking(records, "female")
  end

  def male_mix_ranking
    records = Record.includes(:user, :game).where( users: { :gender => "male" } ).where( games: { team_id: self.id, game_type: "mix" } )
    male_single_ranking = create_ranking(records, "male")
  end

  def female_mix_ranking
    records = Record.includes(:user, :game).where( users: { :gender => "female" } ).where( games: { team_id: self.id, game_type: "mix" } )
    male_single_ranking = create_ranking(records, "female")
  end

  def last_3_games(user)
     #last_games = self.games.last(3)
    last_3_records_by_game = Record.includes(:game).where( user_id: user.id ).where( games: { team_id: self.id }).group(:game_id).last(3)
    last_3_records_by_game.map do |record|
      records = Record.includes(:user).where( game_id: record.game_id)
      records = records.map do |r|
                { :username => r.user.username,
                  :score => r.score
                }
      end
      {
        :game => records
      }
    end
  end

  def today_games
    today_games = self.games.where("created_at >= ?", Time.zone.now.beginning_of_day)
    today_games.map do |game|
      records = Record.includes(:user).where( game_id: game.id)
      records = records.map do |r|
                { :username => r.try(:user).try(:username),
                  :score => r.score
                }
      end
      {
        :game => records
      }
    end
  end

private

  def create_ranking(records, gender)
    wins = records.where( :result => "W" ).group( :user_id ).count
    losses = records.where( :result => "L" ).group( :user_id ).count
    users = self.users.where( gender: gender ).all
    ranking = users.map do |user|
                wins_count = 0
                losses_count = 0
                wins.each do |w|
                  if w[0] == user.id
                    wins_count = w[1]
                  end
                end
                losses.each do |l|
                  if l[0] == user.id
                    losses_count = l[1]
                  end
                end
                if (wins_count + losses_count) > 0
                  rate = wins_count.to_f / (wins_count.to_f + losses_count.to_f ) * 100
                else
                  rate = 0
                end
                games = wins_count + losses_count
                points = wins_count *3 + losses_count * 1
                { user: user,
                  games: games,
                  wins: wins_count,
                  losses: losses_count,
                  rate: rate.round(2),
                  points: points }
              end
    ranking.sort! {|a, b| b[:rate] <=> a[:rate]}
    return ranking
  end
end
