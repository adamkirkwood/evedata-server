get '/celestials' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Celestial.search(params)
    results.to_json
  end
end

get '/celestials/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Celestial.search(params)
    results.to_json
  end
end