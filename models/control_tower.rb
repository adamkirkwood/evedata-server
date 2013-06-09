class ControlTower < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :name, :typeName
  
  default_scope select("typeID, typeName")
  default_scope where("groupID = '365'")
  default_scope where("published = 1")
  default_scope where("typeName NOT LIKE 'QA%'")
  
  scope :with_id, lambda { |value| where('typeID = (?)', value) if value }
  scope :with_name, lambda { |value| where('typeName LIKE ?', "%#{value}%") if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)    
    control_towers = ControlTower.with_id(params[:id])
                                 .with_name(params[:name])
                                 .order(:typeID)
                                 .paginate(:page => params[:page], :per_page => params[:limit])
    control_towers
  end
end