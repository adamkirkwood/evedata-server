class Celestial < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  belongs_to :inventory_group, :foreign_key => "groupID"
  
  alias_attribute :id, :itemID
  alias_attribute :group_id, :groupID
  alias_attribute :solar_system_id, :solarSystemID
  alias_attribute :constellation_id, :constellationID
  alias_attribute :region_id, :regionID
  alias_attribute :name, :itemName
  
  scope :by_type, lambda { |value| where("mapDenormalize.groupID = ?", value) if value }
  scope :within_solar_system, lambda { |value| where(:solarSystemID => SolarSystem.find_id_by_name(value)) if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name, :type_id, :group_id, :solar_system_id, :constellation_id, :region_id]
    options[:only] = [:id, :name, :type_id, :group_id, :solar_system_id, :constellation_id, :region_id]
    super
  end
  
  def self.search(params)
    celestials = Celestial.joins("INNER JOIN invGroups ON mapDenormalize.groupID = invGroups.groupID")
                          .within_solar_system(params[:solar_system])
                          .by_type(params[:type])
                          .limit(params[:limit])
    celestials
  end
end