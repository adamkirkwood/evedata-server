require 'bundler'
Bundler.setup :default
require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'mysql'
require 'will_paginate'
require 'will_paginate/active_record'
require 'grape'
require 'dalli'
require 'memcachier'

['config', 'models', 'routes'].each do |dir|
  Dir["./#{dir}/*.rb"].each { |file| require file }
end

cache_options = {
  :namespace => 'evedata',
  :expires_in => 1.day,
  :compress => true,
  :serializer => :json
}
set :cache, Dalli::Client.new({}, cache_options)

module EveData
  class API
  end
end