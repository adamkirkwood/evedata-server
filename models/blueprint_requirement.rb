class BlueprintRequirement < ActiveRecord::Base
  self.table_name = "ramTypeRequirements"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :activity_id, :activityID
  alias_attribute :material_id, :requiredTypeID
  alias_attribute :damage_per_job, :damagePerJob
  
  default_scope { select("ramTypeRequirements.*") }
  
  scope :by_id, lambda { |value| where("typeID = ?", value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:material_id, :activity_id, :damage_per_job, :images]
    options[:only] = [:material_id, :activity_id, :damage_per_job]
    super
  end
  
  def self.search(params)
    requirements = BlueprintRequirement.order(:requiredTypeID)
                                       .by_id(params[:id])
                                       .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{material_id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{material_id}_64.png"
    }
  end
  
end
