get '/celestials' do
  content_type :json
  
  response = Celestial.search(params)

  return response.to_json  
end

get '/celestials/:id' do
  content_type :json
  
  response = Celestial.search(params)

  return response.to_json  
end