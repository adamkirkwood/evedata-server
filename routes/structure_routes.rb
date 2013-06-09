get '/structures' do
  content_type :json

  response = Structure.search(params)

  return response.to_json
end

get '/structures/:id' do
  content_type :json

  response = Structure.by_id(params[:id])

  return response.to_json
end