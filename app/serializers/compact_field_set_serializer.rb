class CompactFieldSetSerializer < ActiveModel::Serializer

  attributes  :id, 
              :name, 
              :param, 
              :description,
              :created_at, 
              :updated_at

end