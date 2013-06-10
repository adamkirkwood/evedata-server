require 'bundler'
Bundler.setup :default
require 'sinatra/base'
require 'sinatra/activerecord'
require './app'

run EveData::API