require File.join(File.dirname(__FILE__), '..', 'app.rb')

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

require 'simplecov'
SimpleCov.start

require 'sinatra'
require 'rack/test'

['config', 'api', 'models'].each do |dir|
  Dir["./#{dir}/*.rb"].each { |file| require file }
end

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
  config.include RSpecMixin
  
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
