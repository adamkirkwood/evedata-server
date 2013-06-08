require 'bundler'
Bundler.setup :default
require 'sinatra'
require 'json'

get '/' do
  content_type :json
  return { :sushi => ["Maguro", "Hamachi", "Uni", "Saba", "Ebi", "Sake", "Tai"] }.to_json
end
