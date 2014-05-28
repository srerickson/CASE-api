class FieldSet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :description, type: String 
  # TODO created by
  
  embeds_many :field_definitions


  def schemas
  	# Schema.where
  end

end