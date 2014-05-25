class Schema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  validates :name, presence: true

  field :description, type: String 

  embeds_many :field_definitions
  # has_many :field_definitions
  #
end