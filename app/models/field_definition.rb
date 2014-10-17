class FieldDefinition < ActiveRecord::Base

  belongs_to :schema
  has_many :field_values, inverse_of: :field_definition, 
                          dependent: :destroy

  # DEPRECATED -- keeping for migration, but will be removed
  # belongs_to :field_set, inverse_of: :field_definitions

  validates_presence_of :name ,:param

end