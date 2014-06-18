class CompactFieldSetSerializer < ActiveModel::Serializer

  attributes  :id, 
              :name, 
              :param, 
              :description,
              :order,
              :created_at, 
              :updated_at

end