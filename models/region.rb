class Region < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  alias_attribute :id, :itemID
  alias_attribute :name, :itemName
  
  scope :by_id, lambda { |value| where("itemID = ?", value) if value }
  scope :by_name, lambda { |value| where("itemName LIKE ?", "%#{value}%") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    regions = Region.order(:itemID)
                    .by_id(params[:id])
                    .by_name(params[:name])
                    .where(:groupID => 3)
                    .limit(params[:limit])
  end
end