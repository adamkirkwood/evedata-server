class InventoryGroup < ActiveRecord::Base
  self.table_name = "invGroups"
  self.primary_key = "groupID"
  
  has_many :celestials, :foreign_key => "groupID"
  
  alias_attribute :id, :groupID
  alias_attribute :category_id, :categoryID
  alias_attribute :name, :groupName
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
end