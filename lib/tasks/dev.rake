namespace :dev do

  task :fake => :environment do

    Game.delete_all
    Record.delete_all
    Location.delete_all
    Team.delete_all
    users = []
    teams=[]
    locations=[]
    tester = User.create!( :email => "tester@msb.com",
                                  :password => "12345678",
                                  :gender => "male",
                                  :username => "tester")
    10.times do
      users << User.create!( :email => Faker::Internet.email,
                             :password => "12345678",
                             :gender => "male",
                             :username => Faker::Name.first_name)
    end

    10.times do
      users << User.create!( :email => Faker::Internet.email,
                             :password => "12345678",
                             :gender => "female",
                             :username => Faker::Name.first_name)
    end
    3.times do |index|
      locations << Location.create!(:place_name => Faker::Company.name)
      team = Team.create!( :name => "team#{index + 1}", :location => locations.sample )
      # team.location = location

      team_users = users.sample(10)
      team_users << tester
      team_users.each do |user|
        UserTeamship.create!( :user_id => user.id, :team_id => team.id )
      end
      teams << team
    end

    100.times do
      game_type = ["single", "double", "mix"]
      scores = []
      team = teams.sample
      game = Game.create!( :team_id => team.id,
                           :game_type => game_type.sample )
      if game_type == "single"
        players = team.users.sample(2)
        scores = [{user: players[0], score: 21 , result: "W"},
                  {user: players[1], score: 19 , result: "L"}]
      else
        players = team.users.sample(4)
        scores = [{user: players[0], score: 21 , result: "W"},
                  {user: players[1], score: 21 , result: "W"},
                  {user: players[2], score: 19 , result: "L"},
                  {user: players[3], score: 19 , result: "L"}]
      end

      scores.each do |s|
        game.records.create!( :user_id => s[:user].id, :score => s[:score].to_i, :result => s[:result] )
      end
    end
  end
end
