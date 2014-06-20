class FieldSetSerializer < CompactFieldSetSerializer 

  has_many :field_definitions, serializer: FieldDefinitionSerializer

end