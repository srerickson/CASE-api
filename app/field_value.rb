class FieldValue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :case    
  validates_presence_of :case

  field :field_definition_id, type: Moped::BSON::ObjectId
  validates_presence_of :field_definition_id

  field :value, type: String

  def parent_schema
    @parent_schema ||= Schema.where("field_sets.field_definitions._id" => field_definition_id).first
  end

  def parent_field_set
    @parent_field_set ||= parent_schema.nil? ? nil : parent_schema.field_sets.detect{|fs| fs.field_definitions.map(&:_id).include?  field_definition_id }
  end

  def field_definition
    @field_definition ||= parent_field_set.nil? ? nil : parent_field_set.field_definitions.detect{|fd| fd._id == field_definition_id}
  end

end