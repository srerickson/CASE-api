class FieldDefinitionSerializer < ActiveModel::Serializer 

  attributes :id,
             :name,
             :param, 
             :description,
             :type,
             :order,
             :value_options,
             :created_at, 
             :updated_at

end
