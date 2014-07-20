class SchemaSerializer < CompactSchemaSerializer

  attributes :_case_count

  has_many :field_sets, serializer: FieldSetSerializer

  has_one :user

  def _case_count
    object.cases.size
  end

end