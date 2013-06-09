class SolarSystem < ActiveRecord::Base
  self.table_name = "mapSolarSystems"
  self.primary_key = "solarSystemID"
  
  alias_attribute :id, :solarSystemID
  alias_attribute :name, :solarSystemName
  alias_attribute :constellation_id, :constellationID
  alias_attribute :region_id, :regionID
  alias_attribute :security_class, :securityClass
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.find_id_by_name(value)
    return scoped if !value.present?
    select("solarSystemID").where("solarSystemName LIKE ?", "%#{value}%").pluck(:solarSystemID)
  end
end