class Case < ActiveRecord::Base

  validates_presence_of :name

  has_many :field_values, dependent: :destroy, inverse_of: :case
  has_many :field_definitions, through: :field_values
  has_many :field_sets, through: :field_definitions
  has_many :schemas, through: :field_definitions

end