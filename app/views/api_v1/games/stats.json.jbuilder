json.result do
    json.array!(@stats) do |s|
    	json.games @stats[:games]
		json.wins @stats[:wins]
		json.losses @stats[:losses]
		json.rate @stats[:rate]
		json.points @stats[:points]
    end
end