class FieldDefinition < ActiveRecord::Base

  belongs_to :field_set, inverse_of: :field_definitions
  
  has_many :field_values, inverse_of: :field_definition

  validates_presence_of :name
  validates_presence_of :field_set

end