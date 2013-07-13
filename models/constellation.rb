class Constellation < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  alias_attribute :id, :itemID
  alias_attribute :name, :itemName
  
  scope :by_id, lambda { |value| where("itemID = ?", value) if value }
  scope :by_name, lambda { |value| where("lower(itemName) LIKE ?", "%#{value.downcase}%") if value }
  scope :by_region_id, lambda { |value| where(:groupID => 4, :regionID => value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    regions = Constellation.by_id(params[:id])
                           .by_name(params[:name])
                           .by_region_id(params[:region_id])
                           .paginate(:page => params[:page], :per_page => params[:limit])
  end
end