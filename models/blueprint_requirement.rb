class BlueprintRequirement < ActiveRecord::Base
  self.table_name = "ramTypeRequirements"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :activity_id, :activityID
  alias_attribute :activity_name, :activityName
  alias_attribute :material_id, :requiredTypeID
  alias_attribute :material_name, :typeName
  alias_attribute :damage_per_job, :damagePerJob
  
  default_scope { select("ramTypeRequirements.*, ramActivities.activityName, invTypes.typeName") }
  
  scope :by_id, lambda { |value| where("ramTypeRequirements.typeID = ?", value) if value }
  scope :by_activity_id, lambda { |value| where("ramTypeRequirements.activityID = ?", value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:material, :activity, :images]
    options[:only] = [:quantity, :recycle, :damage_per_job]
    super
  end
  
  def self.search(params)
    requirements = BlueprintRequirement.order(:requiredTypeID)
                                       .by_id(params[:id])
                                       .by_activity_id(params[:activity_id])
                                       .joins("LEFT JOIN invTypes ON ramTypeRequirements.requiredTypeID = invTypes.typeID")
                                       .joins("LEFT JOIN ramActivities ON ramTypeRequirements.activityID = ramActivities.activityID")
                                       .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def material
    {
      :id => material_id,
      :name => material_name
    }
  end
  
  def activity
    {
      :id => activity_id,
      :name => activity_name
    }
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{material_id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{material_id}_64.png"
    }
  end
  
end
