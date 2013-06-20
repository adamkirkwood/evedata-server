task :server do
  sh "bundle && bundle exec rerun -- rackup config.ru"
end

task :redis do
  sh "redis-server /usr/local/etc/redis.conf"
end