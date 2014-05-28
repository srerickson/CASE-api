class Schema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :description, type: String
  field :field_sets, type: Array # of FieldSet ObjectIds

  validates :name, presence: true

	# TODO - validated field_sets are all correct type   


end