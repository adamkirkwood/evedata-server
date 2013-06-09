class Star < ActiveRecord::Base
  self.table_name = "mapSolarSystems"
  self.primary_key = "solarSystemID"
  
  alias_attribute :id, :solarSystemID
  alias_attribute :name, :solarSystemName
  
  default_scope select("solarSystemID, solarSystemName, ROUND(security, 1) as security")
  
  scope :with_id, lambda { |value| where('solarSystemID = (?)', value) if value }
  scope :with_name, lambda { |value| where('solarSystemName LIKE ?', "%#{value}%") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name, :security]
    options[:only] = [:id, :name, :security]
    super
  end
  
  def self.search(params)
    stars = Star.with_id(params[:id])
                .with_name(params[:name])
                .with_security(params[:security])
                .limit(params[:limit] || 25)
    stars
  end
  
  def self.with_security(value)
    if value =~ /,/
      min, max = value.split(",")
      where("ROUND(security, 1) >= ROUND(?, 1) AND ROUND(security, 1) <= ROUND(?, 1)", min, max) if value
    else
      where("ROUND(security, 1) = ROUND(?, 1)", value) if value
    end
  end
end