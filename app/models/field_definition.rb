class FieldDefinition < ActiveRecord::Base

  belongs_to :field_set, inverse_of: :field_definitions
  has_one :schema, through: :field_set

  has_many :field_values, inverse_of: :field_definition, 
                          dependent: :destroy


  validates_presence_of :name, :param, :field_set

  validates_uniqueness_of :param, scope: :field_set_id


end