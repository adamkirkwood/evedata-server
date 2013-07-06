class InventoryType < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  has_one :inventory_group, :foreign_key => "groupID"
  
  alias_attribute :id, :typeID
  alias_attribute :group_id, :groupID
  alias_attribute :name, :typeName
  alias_attribute :base_price, :basePrice
  alias_attribute :group, :groupName
  alias_attribute :category, :categoryName
  
  default_scope { where(:published => true) }
  default_scope { select("invTypes.typeID, invTypes.groupID, invTypes.typeName, invTypes.basePrice, invTypes.volume, invTypes.mass, invTypes.capacity, invTypes.description, invGroups.groupName, invCategories.categoryName") }
  
  scope :by_id, lambda { |value| where("typeID = ?", value) if value }
  scope :by_name, lambda { |value| where("typeName = ?", "#{value}") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name, :images, :group, :category, :base_price]
    options[:only] = [:id, :name, :base_price, :volume, :mass, :capacity, :description, :group, :category]
    super
  end
  
  def self.search(params)
    items = InventoryType.order(:typeID)
                         .by_id(params[:id])
                         .by_name(params[:name])
                         .joins("LEFT JOIN invGroups ON invTypes.groupID = invGroups.groupID")
                         .joins("LEFT JOIN invCategories ON invGroups.categoryID = invCategories.categoryID")
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