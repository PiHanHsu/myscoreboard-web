json.result do
  json.array!(@stats) do |s|
    json.team s[:team]
    json.games s[:games]
    json.wins s[:wins]
    json.losses s[:losses]
    json.rate s[:rate]
    json.points s[:points]	
    json.last_3_games s[:last_3_games]
    json.best_double_name s[:best_double_partner_name]
    json.best_double_photo s[:best_double_partner_photo]    
    json.best_mix_name s[:best_mix_partner_name]
    json.best_mix_photo s[:best_mix_partner_photo]
  end
end