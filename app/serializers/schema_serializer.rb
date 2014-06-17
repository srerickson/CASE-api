class SchemaSerializer < CompactSchemaSerializer

  has_many :field_sets, serializer: CompactFieldSetSerializer

end