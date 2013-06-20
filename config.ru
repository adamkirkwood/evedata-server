require 'bundler'
Bundler.setup :default
require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack/cors'
require './app'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

map '/' do
  run Sinatra::Application
end