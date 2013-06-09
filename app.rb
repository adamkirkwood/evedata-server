require 'bundler'
Bundler.setup :default
require './config/environments'
require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'mysql'
require 'kaminari/sinatra'
helpers Kaminari::Helpers::SinatraHelpers

Dir["./models/*.rb"].each {|file| require file}
Dir["./routes/*.rb"].each {|file| require file}

ActiveRecord::Base.include_root_in_json = false

