class InventoryType < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  has_one :inventory_group, :foreign_key => "groupID"
  
  alias_attribute :id, :typeID
  alias_attribute :name, :typeName
  alias_attribute :group_id, :groupID
  alias_attribute :group_name, :groupName
  alias_attribute :category_name, :categoryName
  alias_attribute :category_id, :categoryID
  alias_attribute :base_price, :basePrice
  alias_attribute :portion_size, :portionSize
  
  default_scope { where(:published => true) }
  default_scope { select("invTypes.typeID, invTypes.groupID, invTypes.typeName, invTypes.basePrice, invTypes.volume, invTypes.mass, invTypes.capacity, invTypes.description, invGroups.groupID, invGroups.groupName, invCategories.categoryName, invCategories.categoryID, invTypes.portionSize") }
  
  scope :by_id, lambda { |value| where("typeID = ?", value) if value }
  scope :by_name, lambda { |value| where("lower(typeName) = ?", "#{value.downcase}") if value }
  scope :by_like_name, lambda { |value| where("lower(typeName) LIKE ?", "%#{value.downcase}%") if value }
  scope :by_group_id, lambda { |value| where("invGroups.groupID = ?", "#{value}") if value }
  scope :by_group_name, lambda { |value| where("lower(invGroups.groupName) = ?", "#{value.downcase}") if value }
  scope :by_category_id, lambda { |value| where("invCategories.categoryID = ?", "#{value}") if value }
  scope :by_category_name, lambda { |value| where("lower(invCategories.categoryName) = ?", "#{value.downcase}") if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :images, :group, :category, :base_price, :portion_size]
    options[:only] = [:id, :name, :base_price, :volume, :mass, :capacity, :description]
    super
  end
  
  def self.search(params)
    items = InventoryType.order(:typeID)
                         .by_id(params[:id])
                         .by_name(params[:name])
                         .by_like_name(params[:like_name])
                         .by_group_id(params[:group_id])
                         .by_group_name(params[:group])
                         .by_category_id(params[:category_id])
                         .by_category_name(params[:category])
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
  
  def group
    {
      :id => group_id,
      :name => group_name
    }
  end
  
  def category
    {
      :id => category_id,
      :name => category_name
    }
  end
end
