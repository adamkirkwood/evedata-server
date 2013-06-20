get '/structures' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Structure.search(params)
    results.to_json
  end
end

get '/structures/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Structure.search(params)
    results.to_json
  end
end