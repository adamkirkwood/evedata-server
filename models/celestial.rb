class Celestial < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  belongs_to :inventory_group, :foreign_key => "groupID"
  
  alias_attribute :id, :itemID
  alias_attribute :group_id, :groupID
  alias_attribute :group, :groupName
  alias_attribute :solar_system_id, :solarSystemID
  alias_attribute :constellation_id, :constellationID
  alias_attribute :region_id, :regionID
  alias_attribute :name, :itemName
  alias_attribute :solar_system, :solarSystemName
  alias_attribute :constellation, :constellationName
  alias_attribute :region, :regionName
  
  default_scope select("mapDenormalize.itemName, mapDenormalize.itemID, mapDenormalize.groupID, mapDenormalize.solarSystemID, mapDenormalize.constellationID, mapDenormalize.regionID, ROUND(mapDenormalize.security, 1) as security, mapSolarSystems.solarSystemName, mapConstellations.constellationName, mapRegions.regionName, invGroups.groupName")
  
  scope :by_type, lambda { |value| where("mapDenormalize.groupID = ?", value) if value }
  scope :by_id, lambda { |value| where("mapDenormalize.itemID = ?", value) if value }
  scope :within_solar_system, lambda { |value| { :conditions => ["mapSolarSystems.solarSystemID IN (?)", SolarSystem.find_id_by_name(value)] } if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :type_id, :group_id, :group, :solar_system_id, :constellation_id, :region_id, :security, :solar_system, :constellation, :region]
    options[:only] = [:id, :name, :type_id, :group_id, :group, :solar_system_id, :constellation_id, :region_id, :security, :solar_system, :constellation, :region]
    super
  end
  
  def self.search(params)
    celestials = Celestial.joins("INNER JOIN invGroups ON mapDenormalize.groupID = invGroups.groupID")
                          .joins("LEFT JOIN mapSolarSystems ON mapDenormalize.solarSystemID = mapSolarSystems.solarSystemID")
                          .joins("LEFT JOIN mapConstellations ON mapDenormalize.constellationID = mapConstellations.constellationID")
                          .joins("LEFT JOIN mapRegions ON mapDenormalize.regionID = mapRegions.regionID")
                          .joins("LEFT JOIN mapRegions ON mapDenormalize.regionID = mapRegions.regionID")
                          .by_id(params[:id])
                          .within_solar_system(params[:solar_system])
                          .by_type(params[:type])
                          .with_security(params[:security])
                          .paginate(:page => params[:page], :per_page => params[:limit])
    celestials
  end
  
  def self.with_security(value)
    return scoped if !value.present?
    
    if value =~ /,/
      min, max = value.split(",")
      where("ROUND(security, 1) >= ROUND(?, 1) AND ROUND(security, 1) <= ROUND(?, 1)", min, max) if value
    else
      where("ROUND(security, 1) = ROUND(?, 1)", value) if value
    end
  end
end