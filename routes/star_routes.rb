get '/stars' do
  content_type :json
  
  response = Star.find_by_sql("SELECT solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass FROM mapSolarSystems")

  return response.to_json
end