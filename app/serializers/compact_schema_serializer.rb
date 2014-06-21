class CompactSchemaSerializer < ActiveModel::Serializer

  attributes  :id, 
              :name, 
              :param, 
              :description, 
              :created_at, 
              :updated_at 

  has_one :user

end