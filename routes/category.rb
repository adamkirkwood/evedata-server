get '/categories' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Category.search(params)
    results.to_json
  end
end

get '/categories/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Category.search(params)
    results.to_json
  end
end

get '/categories/:id/groups' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Groups.search(params)
    results.to_json
  end
end
