get '/stars' do
  content_type :json
  
  if params[:id]
    response = Star.find_by_sql("SELECT solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass FROM mapSolarSystems WHERE solarSystemID = #{params[:id]}")

    return response.to_json
  elsif params[:name]
    response = Star.find_by_sql("SELECT solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass FROM mapSolarSystems WHERE solarSystemName LIKE '#{params[:name]}'")

    return response.to_json    
  elsif params[:security]
    response = Star.find_by_sql("SELECT solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass FROM mapSolarSystems WHERE ROUND(security, 1) = ROUND(#{params[:security]}, 1)")

    return response.to_json
  else
    response = Star.find_by_sql("SELECT solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass FROM mapSolarSystems")

    return response.to_json
  end
  
end