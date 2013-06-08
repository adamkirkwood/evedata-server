require 'bundler'
Bundler.setup :default
require 'sinatra'
require 'json'

get '/structures/:id' do
  content_type :json

  if params[:id]
    response = { :structure => { :id => params[:id], :name => 'Structure Name' } }.to_json
    
    return response
  end  
end
