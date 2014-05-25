class Case
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String 
  validates :name, presence: true
  field :description, type: String 

  has_many :field_values 

end