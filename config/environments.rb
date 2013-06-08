require 'uri'

db = URI.parse(ENV['DATABASE_URL'] || 'mysql://evedump:evedump1234@db.descention.net:3306/evedump')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'mysql' ? 'mysql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8',
  :min_messages => "warn"
)