json.name team.name
json.start_time team.start_time
json.end_time team.end_time
json.location team.location.try(:name)
json.users team.users

json.logo_original_url asset_url(team.logo.url)
json.logo_medium_url asset_url(team.logo.url(:medium))
json.logo_thumb_url asset_url(team.logo.url(:thumb))
#Todo 確認尺寸，提供特定的網址 原始或者medium,thumb
