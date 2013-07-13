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
      
      @cache ||= Dalli::Client.new(server, cache_options)
    end
    
    def fetch(url, ttl=nil, options=nil, &block)
      
      begin
        key = create_key(url)
        data ||= EveData::Compressor.inflate(@cache.get(key, options))
      rescue Dalli::RingError
        data = nil
      end      
      
      if data.nil? && block_given?
        data = yield
        begin
          @cache.set(key, EveData::Compressor.deflate(data), ttl)
        rescue Dalli::RingError
          nil
        end
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