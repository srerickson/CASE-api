class FieldSet
  include Mongoid::Document

  field :name, type: String 
  field :description, type: String 
  field :order, type: Integer 
  
  embedded_in :schema
  embeds_many :field_definitions
end