class FieldDefinition < ActiveRecord::Base

  belongs_to :field_set, inverse_of: :field_definitions
  
  validates_presence_of :name
  validates_presence_of :field_set

end