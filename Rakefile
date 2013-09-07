task :server do
  sh "bundle && bundle exec rerun -- rackup config.ru"
end

task :redis do
  sh "redis-server /usr/local/etc/redis.conf"
end

task :memcached do
  sh "memcached -v"
end

task :deploy, [:branch] do |t, args|
  puts "Deploying #{args.branch} to Heroku"
  sh "git push heroku #{args.branch}:master"
  sh "git push origin #{args.branch}"
end