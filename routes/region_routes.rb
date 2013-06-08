get '/regions' do
  content_type :json

  response = Region.search(params)

  return response.to_json
end

get '/regions/:id' do
  content_type :json
  
  response = Region.by_id(params[:id])
  
  return response.to_json
end