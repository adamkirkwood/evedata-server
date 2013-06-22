
newrelic_ignore '/'
get '/' do
  status 200
end

newrelic_ignore '/health_check'
get '/health_check' do
  JSON.dump({ :status => 'OK' })
end