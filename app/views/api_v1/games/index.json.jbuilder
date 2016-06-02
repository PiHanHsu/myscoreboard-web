json.result do 
  json.array!(@teams_ranking) do |team_ranking|
    json.team team_ranking[:team]

    json.male_single do 
      json.array!(team_ranking[:male_single_ranking]) do |r|
        json.user r[:user][:username]
        json.games r[:games]
        json.wins r[:wins]
        json.losses r[:losses]
        json.rate r[:rate]
        json.points r[:points]
      end
    end
    json.female_single do 
      json.array!(team_ranking[:female_single_ranking]) do |r|
        json.user r[:user][:username]
        json.games r[:games]
        json.wins r[:wins]
        json.losses r[:losses]
        json.rate r[:rate]
        json.points r[:points]
      end
    end
    json.male_double do 
      json.array!(team_ranking[:male_double_ranking]) do |r|
        json.user r[:user][:username]
        json.games r[:games]
        json.wins r[:wins]
        json.losses r[:losses]
        json.rate r[:rate]
        json.points r[:points]
      end
    end
    json.female_double do 
      json.array!(team_ranking[:female_double_ranking]) do |r|
        json.user r[:user][:username]
        json.games r[:games]
        json.wins r[:wins]
        json.losses r[:losses]
        json.rate r[:rate]
        json.points r[:points]
      end
    end
    json.male_mix do 
      json.array!(team_ranking[:male_mix_ranking]) do |r|
        json.user r[:user][:username]
        json.games r[:games]
        json.wins r[:wins]
        json.losses r[:losses]
        json.rate r[:rate]
        json.points r[:points]
      end
    end
    json.female_mix do 
      json.array!(team_ranking[:female_mix_ranking]) do |r|
        json.user r[:user][:username]
        json.games r[:games]
        json.wins r[:wins]
        json.losses r[:losses]
        json.rate r[:rate]
        json.points r[:points]
      end
    end
  end
end
