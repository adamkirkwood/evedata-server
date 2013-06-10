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

Dir["./api/*.rb"].each {|file| require file}
Dir["./models/*.rb"].each {|file| require file}
# Dir["./routes/*.rb"].each {|file| require file}
# 
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
    mount ::EveData::Structures
    
    get '/hello' do    
      { "hello" => "world" }
    end
  end
end