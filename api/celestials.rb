module EveData
  class Celestials < Grape::API
    namespace :celestials do
      get do
        uri = request.env['REQUEST_URI']
        key = CacheManager.new.create_key(uri)
        @celectials ||= Dalli::Client.new.fetch(key) do
          Celestial.search(params)  
        end
      end
      
      get '/:id' do
        Celestial.search(params)
      end
    end
  end
end