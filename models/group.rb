class Group < ActiveRecord::Base
  self.table_name = "invGroups"
  self.primary_key = "groupID"
  
  alias_attribute :id, :groupID
  alias_attribute :name, :groupName
  alias_attribute :category_id, :categoryID
  alias_attribute :category_name, :categoryName
  
  default_scope { select("invGroups.*, invCategories.categoryName") }
  
  scope :by_id, lambda { |value| where("groupID = ?", value) if value }
  scope :by_name, lambda { |value| where("lower(groupName) = ?", "#{value.downcase}") if value }
  scope :by_like_name, lambda { |value| where("lower(groupName) LIKE ?", "%#{value.downcase}%") if value }
  scope :by_category_id, lambda { |value| where("invGroups.categoryID = ?", value) if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :images, :category]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    blueprints = Group.order(:groupName)
												 .by_id(params[:id])
												 .by_name(params[:name])
												 .by_like_name(params[:like_name])
												 .by_category_id(params[:category_id])
												 .joins("LEFT JOIN invCategories ON invGroups.categoryID = invCategories.categoryID")
												 .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{id}_64.png"
    }
  end
  
  def category
  	{
  		:id => category_id,
  		:name => category_name
  	}
  end
end
