class FieldDefinitionSerializer < ActiveModel::Serializer 

  attributes :id,
             :name,
             :param, 
             :description,
             :order,
             :value_type,
             :value_options,
             :created_at, 
             :updated_at

end
