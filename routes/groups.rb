get '/groups' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Group.search(params)
    results.to_json
  end
end

get '/groups/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = Group.search(params)
    results.to_json
  end
end
