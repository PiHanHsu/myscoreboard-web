json.result do 

  json.single do
    json.array!(@single_ranking) do |r|
    	json.user r[0]
    	json.wins r[1]
    	json.losses r[2]
    	json.rate r[3]
    	json.points r[4]
    end
  end

  json.double do
    json.array!(@double_ranking) do |r|
    	json.user r[0]
    	json.wins r[1]
    	json.losses r[2]
    	json.rate r[3]
    	json.points r[4]
    end
  end

  json.mix do
    json.array!(@mix_ranking) do |r|
    	json.user r[0]
    	json.wins r[1]
    	json.losses r[2]
    	json.rate r[3]
    	json.points r[4]
    end
  end

end


