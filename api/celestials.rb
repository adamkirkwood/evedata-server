module EveData
  class Celestials < Grape::API
    namespace :celestials do
      get do
        Celestial.search(params)
      end
      
      get '/:id' do
        Celestial.search(params)
      end
    end
  end
end