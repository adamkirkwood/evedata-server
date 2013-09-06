class InventoryBlueprintType < ActiveRecord::Base
  self.table_name = "invBlueprintTypes"
  self.primary_key = "blueprintTypeID"
  
  alias_attribute :id, :blueprintTypeID
  alias_attribute :name, :typeName
  alias_attribute :parent_id, :parentBlueprintTypeID
  alias_attribute :product_id, :productTypeID
  alias_attribute :production_time, :productionTime
  alias_attribute :tech_level, :techLevel
  alias_attribute :waste_factor, :wasteFactor
  alias_attribute :max_production_limit, :maxProductionLimit
  
  #Research Attributes
  alias_attribute :research_productivity_time, :researchProductivityTime
  alias_attribute :research_material_time, :researchMaterialTime
  alias_attribute :research_copy_time, :researchCopyTime
  alias_attribute :research_tech_time, :researchTechTime
  alias_attribute :productivity_modifier, :productivityModifier
  alias_attribute :material_modifier, :materialModifier
  
  #invGroups Attributes
  alias_attribute :group_id, :groupID
  alias_attribute :group_name, :groupName
  
  #invCategories Attributes
  alias_attribute :category_name, :categoryName
  alias_attribute :category_id, :categoryID
  
  default_scope { select("invTypes.*, invBlueprintTypes.*, invGroups.*, invCategories.*") }
  
  scope :by_id, lambda { |value| where("blueprintTypeID = ?", value) if value }
  scope :by_product_id, lambda { |value| where("productTypeID = ?", value) if value }
  scope :by_group_id, lambda { |value| where("invGroups.groupID = ?", "#{value}") if value }
  scope :by_group_name, lambda { |value| where("lower(invGroups.groupName) = ?", "#{value.downcase}") if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :tech_level, :parent_id, :product_id, :production_time, :waste_factor, 
    :max_production_limit, :images, :research, :group, :category]
    options[:only] = [:id, :name, :tech_level, :parent_id, :product_id, :production_time, :waste_factor, :max_production_limit]
    super
  end
  
  def self.search(params)
    blueprints = InventoryBlueprintType.order(:blueprintTypeID)
                                       .by_id(params[:id])
                                       .by_product_id(params[:product_id])
                                       .by_group_id(params[:group_id])
                                       .by_group_name(params[:group])
                                       .joins("LEFT JOIN invTypes ON invBlueprintTypes.blueprintTypeID = invTypes.typeID")
                                       .joins("LEFT JOIN invGroups ON invTypes.groupID = invGroups.groupID")
                                       .joins("LEFT JOIN invCategories ON invGroups.categoryID = invCategories.categoryID")
                                       .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{id}_64.png"
    }
  end
  
  def research
    {
      :productivity_time => research_productivity_time,
      :material_time => research_material_time,
      :copy_time => research_copy_time,
      :tech_time => research_tech_time,
      :productivity_modifier => productivity_modifier,
      :material_modifier => material_modifier
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
