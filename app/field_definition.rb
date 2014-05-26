class FieldDefinition
  include Mongoid::Document

  field :name, type: String 
  field :description, type: String 
  field :order, type: Integer 
  
  validates :name, presence: true, 
                   uniqueness: true
end