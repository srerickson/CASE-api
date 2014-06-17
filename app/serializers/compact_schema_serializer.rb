class CompactSchemaSerializer < ActiveModel::Serializer

  attributes  :id, 
              :name, 
              :param, 
              :description, 
              :field_set_ids,
              :created_at, 
              :updated_at 

  has_one :user

end