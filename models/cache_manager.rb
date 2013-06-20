require 'uri'

module EveData
  class CacheManager
    
    def initialize
      @cache = Dalli::Client.new
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