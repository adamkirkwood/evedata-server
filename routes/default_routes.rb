get '/' do
  status 200
end

get '/health_check' do
  JSON.dump({ :status => 'OK' })
end