class FieldSet < ActiveRecord::Base

  belongs_to :schema, inverse_of: :field_sets

  has_many :field_definitions, -> {order(:order)},
                               dependent: :destroy, 
                               inverse_of: :field_set
                               
  validates_presence_of :name, :param, :schema
  validates_uniqueness_of :param, scope: :schema_id 
  
  accepts_nested_attributes_for :field_definitions, allow_destroy: true


end