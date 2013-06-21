require 'bundler'
Bundler.setup :default
require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'mysql'
require 'will_paginate'
require 'will_paginate/active_record'
require 'dalli'

['config', 'models', 'routes'].each do |dir|
  Dir["./#{dir}/*.rb"].each { |file| require file }
end

configure :production do
  require 'newrelic_rpm'
  require 'memcachier'
end