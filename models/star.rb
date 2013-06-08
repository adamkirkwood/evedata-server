class Star < ActiveRecord::Base
  self.table_name = "mapSolarSystems"
  self.primary_key = "solarSystemID"
  
  alias_attribute :id, :solarSystemID
  alias_attribute :name, :solarSystemName
  alias_attribute :security_class, :securityClass
  
  def as_json(options={})
    options[:methods] = [:id, :name, :security, :security_class]
    options[:only] = [:id, :name, :security, :security_class]
    super
  end
end