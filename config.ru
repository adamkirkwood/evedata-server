require 'bundler'
Bundler.setup :default
require 'sinatra/base'
require './app'

map '/' do
  run Sinatra::Application
end