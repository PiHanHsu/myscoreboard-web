json.results do
  json.array!(@users) do |user|

    json.username user.username
    json.photo user.head.url

  end
end
