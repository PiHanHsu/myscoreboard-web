json.result do
    json.array!(@stats) do |s|
      json.team s[:team]
      json.games s[:games]
	  json.wins s[:wins]
      json.losses s[:losses]
	  json.rate s[:rate]
	  json.points s[:points]	
    json.best_double s[:best_double_partner]
    json.best_mix s[:best_mix_partner]
    end
end