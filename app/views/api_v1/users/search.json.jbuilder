json.results do
  json.array!(@users) do |user|

    json.id user.id
    json.username user.username
    json.photo user.photo

  end
end
