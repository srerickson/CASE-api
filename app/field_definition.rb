class FieldDefinition
  include Mongoid::Document
  # include Mongoid::Timestamps
  field :name, type: String 
  validates :name, presence: true, 
                   uniqueness: true

  field :description, type: String 
  field :order, type: Integer 

  embedded_in :schema
  #belongs_to :schema
end