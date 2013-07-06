class InventoryType < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :group_id, :groupID
  alias_attribute :name, :typeName
  
  default_scope { where(:published => true) }
  
  scope :by_id, lambda { |value| where("typeID = ?", value) if value }
  scope :by_name, lambda { |value| where("typeName = ?", "#{value}") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    puts params
    items = InventoryType.order(:typeID)
                    .by_id(params[:id])
                    .by_name(params[:name])
                    .paginate(:page => params[:page], :per_page => params[:limit])
    puts items
    items
  end
end