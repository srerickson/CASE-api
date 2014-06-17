class FieldValue < ActiveRecord::Base

  belongs_to :field_definition, inverse_of: :field_values
  has_one :field_set, through: :field_definition

  belongs_to :case, inverse_of: :field_values  
  validates_presence_of :case

  # field :field_definition_id, type: Moped::BSON::ObjectId
  # validates_presence_of :field_definition_id

  # field :value, type: String

  # def parent_field_set
  #   @parent_field_set ||= FieldSet.where("field_definitions._id" => field_definition_id).first
  # end

  # def field_definition
  #   @field_definition ||= parent_field_set.nil? ? nil : parent_field_set.field_definitions.detect{|fd| fd._id == field_definition_id}
  # end

  # Example of searching by json value
  # FieldValue.where("value->>'text' = 'onetwothree'")


  # FieldValue.where("(select json_object_keys(value)) = 'array'").size
  # select * from field_values where (select json_object_keys(value)) = 'array';

end