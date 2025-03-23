
for _,connection in pairs (data.raw["space-connection"]) do 
    if connection == nil then
        break
    end
    if connection.from == "wanderer" then
        data.raw["space-connection"][connection.name].from = "wanderer"
    end 
    if connection.to == "wanderer" then
        data.raw["space-connection"][connection.name].to = "wanderer"
    end
end
	
