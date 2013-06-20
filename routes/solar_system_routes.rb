get '/solar_systems' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = SolarSystem.search(params)
    results.to_json
  end
end

get '/solar_systems/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = SolarSystem.search(params)
    results.to_json
  end
end