require 'bundler'
Bundler.setup :default
require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'mysql2'

ActiveRecord::Base.include_root_in_json = false

class Structure < ActiveRecord::Base
  self.table_name = "mapDenormalize"
  self.primary_key = "itemID"
  
  alias_attribute :id, :typeID
  alias_attribute :name, :typeName
  
  def as_json(options={})
    options[:methods] = [:id, :name]
    options[:only] = [:id, :name]
    super
  end
end
 
get '/structures/:id' do
  content_type :json

  if params[:id]
    Structure.establish_connection(
      adapter: 'mysql2', 
      host: 'external-db.s6547.gridserver.com',
      database: 'db6547_evedata',
      username: 'db6547_evedata',
      password: 'evedataio')

    response = Structure.find_by_sql("SELECT invTypes.typeID, invTypes.typeName
      FROM invTypes
      INNER JOIN invGroups ON invTypes.groupID = invGroups.groupID
      WHERE invGroups.categoryID = 23 /*Structure*/
          AND invTypes.groupID != 365 /*Exclude Control Towers*/
          AND invTypes.published = 1 
          AND invTypes.typeName NOT LIKE '%QA%'
          AND invTypes.typeID = #{params[:id]}")

    return response.to_json
  end
end

get '/structures' do
  Structure.establish_connection(
    adapter: 'mysql2', 
    host: 'external-db.s6547.gridserver.com',
    database: 'db6547_evedata',
    username: 'db6547_evedata',
    password: 'evedataio')
  
  response = Structure.find_by_sql("SELECT invTypes.typeID, invTypes.typeName
    FROM invTypes
    INNER JOIN invGroups ON invTypes.groupID = invGroups.groupID
    WHERE invGroups.categoryID = 23 /*Structure*/
        AND invTypes.groupID != 365 /*Exclude Control Towers*/
        AND invTypes.published = 1 
        AND invTypes.typeName NOT LIKE '%QA%'")
  
  return response.to_json
end