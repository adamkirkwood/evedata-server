get '/blueprints' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = InventoryBlueprintType.search(params)
    results.to_json
  end
end

get '/blueprints/:id' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = InventoryBlueprintType.search(params)
    results.to_json
  end
end

get '/blueprints/:id/requirements' do
  content_type :json
  
  response ||= EveData::CacheManager.new.fetch(request.env['REQUEST_URI']) do
    results = BlueprintRequirement.search(params)
    results.to_json
  end
end
