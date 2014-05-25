class FieldValue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :case    
  validates_presence_of :case

  field :field_definition_id, type: Moped::BSON::ObjectId
  validates_presence_of :field_definition_id

  field :value, type: String

  def field_definition
    Schema.where("field_definitions._id" => field_definition_id).first
  end

end