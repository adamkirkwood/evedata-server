class SolarSystem < ActiveRecord::Base
  self.table_name = "mapSolarSystems"
  self.primary_key = "solarSystemID"
  
  alias_attribute :id, :solarSystemID
  alias_attribute :name, :solarSystemName
  alias_attribute :constellation_id, :constellationID
  alias_attribute :region_id, :regionID
  
  default_scope select("solarSystemID, solarSystemName, ROUND(security, 1) as security")
  
  scope :with_id, lambda { |value| where('solarSystemID = (?)', value) if value }
  scope :with_name, lambda { |value| where('lower(solarSystemName) LIKE ?', "%#{value.downcase}%") if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :security]
    options[:only] = [:id, :name, :security]
    super
  end
  
  def self.find_id_by_name(value)
    return scoped if !value.present?
    select("solarSystemID").where("lower(solarSystemName) = ?", "%#{value.downcase}%").pluck(:solarSystemID)
  end
  
  def self.search(params)
    solar_systems = SolarSystem.with_id(params[:id])
                               .with_name(params[:name])
                               .with_security(params[:security])
                               .paginate(:page => params[:page], :per_page => params[:limit])
    solar_systems
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