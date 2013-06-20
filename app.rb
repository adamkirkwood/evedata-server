require 'bundler'
Bundler.setup :default
require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'mysql'
require 'will_paginate'
require 'will_paginate/active_record'
require 'grape'

['config', 'api', 'models'].each do |dir|
  Dir["./#{dir}/*.rb"].each { |file| require file }
end

$redis = Redis.new

module EveData
  class API < Grape::API
    format :json
    default_format :json
    
    mount ::EveData::Celestials
    mount ::EveData::ControlTowers
    mount ::EveData::Regions
    mount ::EveData::SolarSystems
    mount ::EveData::Structures
  end
end