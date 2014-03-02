class InventoryTypeMaterial < ActiveRecord::Base
  self.table_name = "invTypeMaterials"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :material_id, :materialTypeID
  alias_attribute :material_name, :typeName
  alias_attribute :material_blueprint_id, :blueprintTypeID
  
  alias_attribute :group_id, :groupID
  alias_attribute :group_name, :groupName
  
  alias_attribute :category_name, :categoryName
  alias_attribute :category_id, :categoryID
  
  default_scope { select("invTypeMaterials.*, invTypes.*, invGroups.*, invCategories.*, invBlueprintTypes.blueprintTypeID") }
  
  scope :by_id, lambda { |value| where("invTypeMaterials.typeID = ?", value) if value }
  scope :by_category_id, lambda { |value| where("invCategories.categoryID = ?", value) if value }
  scope :by_not_category_id, lambda { |value| where("invCategories.categoryID != ?", value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:material, :images, :group, :category]
    options[:only] = [:quantity]
    super
  end
  
  def self.search(params)
    materials = InventoryTypeMaterial.order(:materialTypeID)
                                     .by_id(params[:id])
                                     .by_category_id(params[:category_id])
                                     .by_not_category_id(params[:not_category_id])
                                     .joins("LEFT JOIN invTypes ON invTypeMaterials.materialTypeID = invTypes.typeID")
                                     .joins("LEFT JOIN invGroups ON invTypes.groupID = invGroups.groupID")
                                     .joins("LEFT JOIN invCategories ON invGroups.categoryID = invCategories.categoryID")
																		 .joins("LEFT JOIN invBlueprintTypes ON invTypes.typeID = invBlueprintTypes.productTypeID")
                                     .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def material
    {
      :id => material_id,
      :name => material_name,
			:blueprint_id => material_blueprint_id
    }
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{material_id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{material_id}_64.png"
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
