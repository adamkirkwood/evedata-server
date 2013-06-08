class Star < ActiveRecord::Base
  self.table_name = "mapSolarSystems"
  self.primary_key = "solarSystemID"
  
  alias_attribute :id, :solarSystemID
  alias_attribute :name, :solarSystemName
  alias_attribute :security_class, :securityClass
  
  default_scope select("solarSystemID, solarSystemName, ROUND(security, 1) as security, securityClass")
  
  scope :with_id, lambda { |value| where('id = (?)', value) if value }
  scope :with_name, lambda { |value| where('solarSystemName LIKE ?', "%#{value}%") if value }
  scope :with_security_class, lambda { |value| where('securityClass LIKE ?', "%#{value}%") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name, :security, :security_class]
    options[:only] = [:id, :name, :security, :security_class]
    super
  end
  
  def self.search(params)
    stars = Star.with_id(params[:id])
                .with_name(params[:name])
                .with_security(params[:security])
                .with_security_class(params[:security_class])
                .order(:solarSystemID)
                .limit(params[:limit])
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