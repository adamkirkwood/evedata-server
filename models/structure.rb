class Structure < ActiveRecord::Base
  self.table_name = "invTypes"
  self.primary_key = "typeID"
  
  alias_attribute :id, :typeID
  alias_attribute :name, :typeName
  
  default_scope select("invTypes.typeID, invTypes.typeName")

  scope :by_id, lambda { |value| where("typeID = ?", value) if value }
  scope :by_name, lambda { |value| where("invTypes.typeName LIKE ?", "%#{value}%") if value }
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    structures = Structure.joins("INNER JOIN invGroups ON invTypes.groupID = invGroups.groupID")
                          .where("invGroups.categoryID = 23 
                                  AND invTypes.groupID != 365 
                                  AND invTypes.published = 1
                                  AND invTypes.typeName NOT LIKE '%QA%'")
                          .order(:typeID)
                          .by_id(params[:id])
                          .by_name(params[:name])
                          .limit(params[:limit])
    structures
  end
end