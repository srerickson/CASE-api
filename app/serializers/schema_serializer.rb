class SchemaSerializer < CompactSchemaSerializer

  has_many :field_sets, serializer: FieldSetSerializer

end