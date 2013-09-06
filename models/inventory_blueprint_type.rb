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
  
  #Modifiers
  alias_attribute :productivity_modifier, :productivityModifer
  alias_attribute :material_modifier, :materialModifer
  
  default_scope { select("invTypes.typeName, invBlueprintTypes.*") }
  
  scope :by_id, lambda { |value| where("blueprintTypeID = ?", value) if value }
  scope :by_product_id, lambda { |value| where("productTypeID = ?", value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :tech_level, :parent_id, :product_id, :production_time, :waste_factor, 
    :max_production_limit, :research_productivity_time, :research_material_time, :research_copy_time, :research_tech_time,
    :images]
    options[:only] = [:id, :name, :tech_level, :parent_id, :product_id, :production_time, :waste_factor, 
    :max_production_limit, :research_productivity_time, :research_material_time, :research_copy_time, :research_tech_time]
    super
  end
  
  def self.search(params)
    blueprints = InventoryBlueprintType.order(:blueprintTypeID)
                                       .by_id(params[:id])
                                       .by_product_id(params[:product_id])
                                       .joins("INNER JOIN invTypes ON invBlueprintTypes.blueprintTypeID = invTypes.typeID")
                                       .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{id}_64.png"
    }
  end
end
