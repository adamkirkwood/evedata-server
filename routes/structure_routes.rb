get '/structures/:id' do
  content_type :json

  if params[:id]
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
  content_type :json
  
  if params[:name]
    response = Structure.find_by_sql("SELECT invTypes.typeID, invTypes.typeName
      FROM invTypes
      INNER JOIN invGroups ON invTypes.groupID = invGroups.groupID
      WHERE invGroups.categoryID = 23 /*Structure*/
          AND invTypes.groupID != 365 /*Exclude Control Towers*/
          AND invTypes.published = 1 
          AND invTypes.typeName NOT LIKE '%QA%'
          AND invTypes.typeName LIKE '%#{params[:name]}%'")

    return response.to_json
  else
    response = Structure.find_by_sql("SELECT invTypes.typeID, invTypes.typeName
      FROM invTypes
      INNER JOIN invGroups ON invTypes.groupID = invGroups.groupID
      WHERE invGroups.categoryID = 23 /*Structure*/
          AND invTypes.groupID != 365 /*Exclude Control Towers*/
          AND invTypes.published = 1 
          AND invTypes.typeName NOT LIKE '%QA%'")

    return response.to_json
  end
end