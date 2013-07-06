class InventoryType < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :group_id, :groupID
  alias_attribute :name, :typeName
  alias_attribute :base_price, :basePrice
  
  default_scope { where(:published => true) }
  
  scope :by_id, lambda { |value| where("typeID = ?", value) if value }
  scope :by_name, lambda { |value| where("typeName = ?", "#{value}") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name, :images]
    options[:only] = [:id, :name, :base_price, :volume, :mass, :capacity, :description]
    super
  end
  
  def self.search(params)
    items = InventoryType.order(:typeID)
                         .by_id(params[:id])
                         .by_name(params[:name])
                         .paginate(:page => params[:page], :per_page => params[:limit])
    items
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{id}_64.png"
    }
  end
end