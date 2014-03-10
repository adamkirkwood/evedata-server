get '/stations' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Station.search(params)
    results.to_json
  end
end

get '/stations/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Station.search(params)
    results.to_json
  end
end
