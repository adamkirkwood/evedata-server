module EveData
  class SolarSystems < Grape::API
    namespace :solar_systems do
      get do
        SolarSystem.search(params)
      end
      
      get '/:id' do
        SolarSystem.search(params)
      end
    end
  end
end