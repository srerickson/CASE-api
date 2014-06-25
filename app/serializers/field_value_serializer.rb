class FieldValueSerializer < ActiveModel::Serializer
  attributes  :id,
              :case_id,
              :field_definition_id,
              :user_id,
              :type,
              :value,
              :created_at,
              :updated_at
end