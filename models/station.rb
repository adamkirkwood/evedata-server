class Station < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  alias_attribute :id, :itemID
  alias_attribute :name, :itemName
  alias_attribute :type_id, :typeID
  alias_attribute :group_id, :groupID
  alias_attribute :solar_system_id, :solarSystemID
  alias_attribute :constellation_id, :constellationID
  alias_attribute :region_id, :regionID
  
  default_scope select("mapDenormalize.*")

  scope :by_id, lambda { |value| where("itemID = ?", value) if value }
  scope :by_name, lambda { |value| where('lower(itemName) LIKE ?', "%#{value.downcase}%") if value }
  scope :by_solar_system, lambda { |value| where("solarSystemID = ?", value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :type_id, :group_id, :solar_system_id, :constellation_id, :region_id]
    options[:only] = [:id, :name, :type_id, :group_id, :solar_system_id, :constellation_id, :region_id]
    super
  end
  
  def self.search(params)
    stations = Station.where("groupID = 15")
                      .order(:itemName)
                      .by_id(params[:id])
                      .by_name(params[:name])
                      .by_solar_system(params[:solar_system_id])
                      .paginate(:page => params[:page], :per_page => params[:limit])
    stations
  end
end
