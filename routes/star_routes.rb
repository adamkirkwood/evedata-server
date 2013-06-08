get '/stars' do
  content_type :json
  
  if params[:id]
    response = Star.select("solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass").where("solarSystemID = ?", params[:id])

    return response.to_json
  elsif params[:name]
    response = Star.select("solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass").where("solarSystemName LIKE ?", "%#{params[:name]}%")

    return response.to_json    
  elsif params[:security]
    response = Star.select("solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass").where("ROUND(security, 1) = ROUND(?, 1)", params[:security])

    return response.to_json
  else
    response = Star.select("solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass").all

    return response.to_json
  end
  
end