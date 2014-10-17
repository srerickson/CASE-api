class FieldValue < ActiveRecord::Base

  belongs_to :field_definition, inverse_of: :field_values
  has_one :schema, through: :field_definition

  belongs_to :case, inverse_of: :field_values  

  validates_presence_of :case, :field_definition #, :value

  # Example of searching by json value
  # FieldValue.where("value->>'text' = 'onetwothree'")


  # FieldValue.where("(select json_object_keys(value)) = 'array'").size
  # select * from field_values where (select json_object_keys(value)) = 'array';

end