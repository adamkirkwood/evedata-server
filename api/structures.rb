module EveData
  class Structures < Grape::API
    namespace :structures do
      get do
        Structure.search(params)
      end
      
      get '/:id' do
        Structure.by_id(params[:id])
      end
    end
  end
end