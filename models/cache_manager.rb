require 'uri'

module EveData
  class CacheManager
    
    def create_key(value)
      path = URI.parse(value).path[1..-1]
      
      params = URI.parse(value).query
      params = CGI.parse(params)
      params = params.sort.map { |k,v| "#{k}:#{v.join(':')}" }.join(':')
      
      [path, params].join(':')
    end
    
  end
end