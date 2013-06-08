class ControlTower < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :name, :typeName
  
  default_scope select("typeID, typeName")
  default_scope where("groupID = '365'")
  default_scope where("published = 1")
  default_scope where("typeName NOT LIKE 'QA%'")
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    control_towers = ControlTower.order(:typeID)
    control_towers = ControlTower.where("typeName LIKE ?", "%#{params[:name]}%") if params[:name].present?
    control_towers = ControlTower.where("typeID = ?", params[:id]) if params[:id].present?
    control_towers
  end
end