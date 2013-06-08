get '/stars' do
  content_type :json
  
  response = Star.search(params)

  return response.to_json  
end