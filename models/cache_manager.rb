require 'uri'

module EveData
  class CacheManager
    
    def initialize
      server = "localhost:11211"
      cache_options = {
        :namespace => 'evedata',
        :expires_in => 1.day,
        :compress => true
      }
      
      if ENV['RACK_ENV'] == "production"
        server = ENV["MEMCACHIER_SERVERS"]
        {
          :username => ENV["MEMCACHIER_USERNAME"],
          :password => ENV["MEMCACHIER_PASSWORD"]
        }.merge(cache_options)
      end
      
      @cache = Dalli::Client.new(server, cache_options)
    end
    
    def fetch(url, ttl=nil, options=nil, &block)
      key = create_key(url)
      
      data = @cache.get(key, options)
      
      if data.nil? && block_given?
        data = yield
        @cache.set(key, data, ttl)
      end
      
      data
    end
    
    def create_key(value)
      path = URI.parse(value).path[1..-1].gsub('/',":")
      
      params = URI.parse(value).query

      if !params.nil?
        params = CGI.parse(params)
        params = params.sort.map { |k,v| "#{k}:#{v.join(':')}" }.join(':')
      end
      
      params ? [path, params].join(':') : path
    end
    
  end
end