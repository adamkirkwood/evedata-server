require 'bundler'
Bundler.setup :default
require './config/environments'
require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'mysql'
require 'will_paginate'
require 'will_paginate/active_record'
require 'grape'

['api', 'models'].each do |dir|
  Dir["./#{dir}/*.rb"].each { |file| require file }
end

# before do
#   headers['Access-Control-Allow-Origin'] = '*'
#   headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
#   headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, X-CSRF-Token'
# end

ActiveRecord::Base.include_root_in_json = false

module EveData
  class API < Grape::API
    format :json
    default_format :json
    
    mount ::EveData::Celestials
    mount ::EveData::ControlTowers
    mount ::EveData::Regions
    mount ::EveData::SolarSystems
    mount ::EveData::Structures
    
    get '/hello' do    
      { "hello" => "world" }
    end
  end
end