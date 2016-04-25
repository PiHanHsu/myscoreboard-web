json.array!(@games) do |game|
    json.id game.id
	json.team_id game.team_id
	json.created_at game.created_at
	json.updated_at game.updated_at
end
