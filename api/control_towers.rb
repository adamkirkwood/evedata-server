module EveData
  class ControlTowers < Grape::API
    namespace :control_towers do
      get do
        ControlTower.search(params)
      end
      
      get '/:id' do
        ControlTower.by_id(params[:id])
      end
    end
  end
end