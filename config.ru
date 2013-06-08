require 'bundler'
Bundler.setup :default
require 'sinatra/base'
require 'sinatra/activerecord'
require './app'

map '/' do
  run Sinatra::Application
end