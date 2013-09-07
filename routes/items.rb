get '/items' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = InventoryType.search(params)
    results.to_json
  end
end

get '/items/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = InventoryType.search(params)
    results.to_json
  end
end

get '/items/:id/materials' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = InventoryTypeMaterial.search(params)
    results.to_json
  end
end
