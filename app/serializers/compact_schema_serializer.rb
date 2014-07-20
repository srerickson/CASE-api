class CompactSchemaSerializer < ActiveModel::Serializer

  attributes  :id, 
              :name, 
              :param, 
              :description, 
              :user_id, 
              :created_at,
              :updated_at 

end