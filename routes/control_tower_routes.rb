get '/control_towers' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = ControlTower.search(params)
    results.to_json
  end
end

get '/control_towers/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = ControlTower.search(params)
    results.to_json
  end
end