class Team < ActiveRecord::Base
  belongs_to :location
  has_many :games
  has_many :user_teamships
  has_many :users, :through => :user_teamships
  validates_length_of :name, :maximum => 20
  validates_presence_of :name
  accepts_nested_attributes_for :location



  has_attached_file :logo, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

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
                points = wins_count *3 + losses_count * 1
                { user: user,
                  wins: wins_count,
                  losses: losses_count,
                  rate: rate.round(2),
                  points: points }
              end
    ranking.sort! {|a, b| b[:points] <=> a[:points]}
    return ranking
  end
end
