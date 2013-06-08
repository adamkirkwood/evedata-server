get '/control_towers' do
  content_type :json

  response = ControlTower.search(params)

  return response.to_json
end

get '/control_towers/:id' do
  content_type :json

  response = ControlTower.search(params)

  return response.to_json
end