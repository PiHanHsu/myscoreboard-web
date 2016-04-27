json.results do
  json.array!(@teams) do |t|
    json.partial! 'team', team: t
  end
end
