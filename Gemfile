if RUBY_PLATFORM =~ /java/
  ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.1'
else
  ruby '1.9.3'
end

source 'http://rubygems.org'

gem 'sinatra'
gem 'rack'
gem 'rack-cors'
gem 'sinatra-activerecord'
gem 'will_paginate'
gem 'newrelic_rpm'

# datastores
if defined?(JRUBY_VERSION)
  gem 'jdbc-mysql'
else
  gem 'mysql'
end
gem 'dalli'
gem 'memcachier'

# misc
gem 'snappy'

group :production do
  gem 'puma'
end

group :development do
  gem 'heroku'
  gem 'rerun'
  gem 'rb-fsevent', '~> 0.9'
  gem 'tux'
  gem 'rake'
  gem 'foreman'
  gem 'rack'
  gem 'dotenv'
end

group :test do
  gem 'guard'
  gem 'guard-rspec'
  gem 'rspec'
  gem 'simplecov', :require => false
end