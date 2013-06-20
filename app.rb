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

module EveData
  class API
  end
end