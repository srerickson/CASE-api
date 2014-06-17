class FieldSetSerializer < ActiveModel::Serializer

  attributes :id, :name, :param, :description

  has_many :field_definitions

end