class Category < ActiveRecord::Base
  self.table_name = "invCategories"
  self.primary_key = "categoryID"
  
  alias_attribute :id, :categoryID
  alias_attribute :name, :categoryName
  
  default_scope { where(:published => true) }
  default_scope { select("invCategories.*") }
  
  scope :by_id, lambda { |value| where("categoryID = ?", value) if value }
  scope :by_name, lambda { |value| where("lower(categoryName) = ?", "#{value.downcase}") if value }
  scope :by_like_name, lambda { |value| where("lower(categoryName) LIKE ?", "%#{value.downcase}%") if value }
  
  self.per_page = 25
  
  def as_json(options={})
    options[:methods] = [:id, :name, :images]
    options[:only] = [:id, :name]
    super
  end
  
  def self.search(params)
    blueprints = Category.order(:categoryName)
												 .by_id(params[:id])
												 .by_name(params[:name])
												 .by_like_name(params[:like_name])
												 .paginate(:page => params[:page], :per_page => params[:limit])
  end
  
  def images
    {
      :small => "http://image.eveonline.com/Type/#{id}_32.png",
      :thumb => "http://image.eveonline.com/Type/#{id}_64.png"
    }
  end
end
