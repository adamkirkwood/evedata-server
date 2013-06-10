module EveData
  class Regions < Grape::API
    namespace :regions do
      get do
        Region.search(params)
      end
      
      get '/:id' do
        Region.by_id(params[:id])
      end
      
      get '/:region_id/constellations' do
        Constellation.search(params)
      end
      
      get '/:region_id/constellations/:id' do
        Constellation.search(params)
      end
    end
  end
end