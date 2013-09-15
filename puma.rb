#!/usr/bin/env puma

# root = "#{Dir.getwd}"

# activate_control_app "tcp://127.0.0.1:9293"
# bind "unix:///tmp/puma.pumatra.sock"
# pidfile "#{root}/tmp/pids/puma.pid"
# rackup "#{root}/config.ru"
# state_path "#{root}/tmp/pids/puma.state"



on_worker_boot do
  workers 3
  preload_app!
  threads 0, 5

  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL'] || 5
    ActiveRecord::Base.establish_connection
  end
end