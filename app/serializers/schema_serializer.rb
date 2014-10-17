class SchemaSerializer < CompactSchemaSerializer

  attributes :layout, :_case_count

  has_many :field_definitions, serializer: FieldDefinitionSerializer
  has_one :user

  def _case_count
    object.cases.size
  end

end