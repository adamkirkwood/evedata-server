ActiveRecord::Base.include_root_in_json = false

WillPaginate.per_page = 25

cache_options = {
  :namespace => 'evedata',
  :expires_in => 1.day,
  :compress => true
}
$cache = Dalli::Client.new({}, cache_options)