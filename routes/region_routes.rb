get '/regions' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Region.search(params)
    results.to_json
  end
end

get '/regions/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Region.search(params)
    results.to_json
  end
end

get '/regions/:region_id/constellations' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Constellation.search(params)
    results.to_json
  end
end

get '/regions/:region_id/constellations/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Constellation.search(params)
    results.to_json
  end
end