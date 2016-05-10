json.team do
  json.id team.id
  json.name team.name
  json.start_time_hour "%02d" %team.start_time.hour
  json.start_time_min "%02d" %team.start_time.min
  json.end_time_hour "%02d" %team.end_time.hour
  json.end_time_min "%02d" %team.end_time.min
  json.day team.day
  json.location team.location
  json.teammembers team.users
  json.logo_original_url asset_url(team.logo.url)
end

json.teammates do
  json.array!(team.users) do |u|
    json.username u.username
    json.user_id u.id
    json.user_photo asset_url(u.head.url)
  end
end

# json.logo_medium_url asset_url(team.logo.url(:medium))
# json.logo_thumb_url asset_url(team.logo.url(:thumb))
#Todo 確認尺寸，提供特定的網址 原始或者medium,thumb
