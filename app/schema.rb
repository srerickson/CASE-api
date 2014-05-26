class Schema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :description, type: String 

  validates :name, presence: true
  
  # embeds_many :field_definitions
  embeds_many :field_sets 
end