class Celestial < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  belongs_to :inventory_group, :foreign_key => "groupID"
  
  alias_attribute :id, :itemID
  alias_attribute :name, :itemName
  alias_attribute :group_id, :groupID
  alias_attribute :group_name, :groupName
  alias_attribute :solar_system_id, :solarSystemID
  alias_attribute :solar_system_name, :solarSystemName
  alias_attribute :constellation_id, :constellationID
  alias_attribute :constellation_name, :constellationName
  alias_attribute :region_id, :regionID
  alias_attribute :region_name, :regionName
  
  default_scope select("mapDenormalize.itemName, mapDenormalize.itemID, mapDenormalize.groupID, mapDenormalize.solarSystemID, mapDenormalize.constellationID, mapDenormalize.regionID, ROUND(mapDenormalize.security, 1) as security, mapSolarSystems.solarSystemName, mapConstellations.constellationName, mapRegions.regionName, invGroups.groupName")
  
  scope :by_group_name, lambda { |value| where("lower(mapDenormalize.groupName) = ?", value.downcase) if value }
  scope :by_group_id, lambda { |value| where("mapDenormalize.groupID IN (?)", value.split(',').map { |s| s.to_i }) if value }
  scope :by_id, lambda { |value| where("mapDenormalize.itemID = ?", value) if value }
  scope :by_name, lambda { |value| where("lower(mapDenormalize.itemName) = ?", value.downcase) if value }
  scope :within_solar_system_id, lambda { |value| { :conditions => ["mapSolarSystems.solarSystemID IN (?)", value.split(',').map { |s| s.to_i }] } if value }
  scope :within_solar_system_name, lambda { |value| { :conditions => ["mapSolarSystems.solarSystemID IN (?)", SolarSystem.find_id_by_name(value.downcase)] } if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :type_id, :group, :security, :solar_system, :constellation, :region]
    options[:only] = [:id, :name, :type_id, :security]
    super
  end
  
  def self.search(params)
    celestials = Celestial.joins("INNER JOIN invGroups ON mapDenormalize.groupID = invGroups.groupID")
                          .joins("LEFT JOIN mapSolarSystems ON mapDenormalize.solarSystemID = mapSolarSystems.solarSystemID")
                          .joins("LEFT JOIN mapConstellations ON mapDenormalize.constellationID = mapConstellations.constellationID")
                          .joins("LEFT JOIN mapRegions ON mapDenormalize.regionID = mapRegions.regionID")
                          .joins("LEFT JOIN mapRegions ON mapDenormalize.regionID = mapRegions.regionID")
                          .by_id(params[:id])
                          .by_name(params[:name])
                          .within_solar_system_id(params[:solar_system_id])
                          .within_solar_system_name(params[:solar_system])
                          .by_group_name(params[:group])
                          .by_group_id(params[:group_id])
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
  
  def group
    {
      :id => group_id,
      :name => group_name
    }
  end
  
  def constellation
    {
      :id => constellation_id,
      :name => constellation_name
    }
  end
  
  def region
    {
      :id => region_id,
      :name => region_name
    }
  end
  
  def solar_system
    {
      :id => solar_system_id,
      :name => solar_system_name
    }
  end
end