class FieldValue
  # include Mongoid::Document
  # include Mongoid::Timestamps

  # belongs_to :case    
  # validates_presence_of :case

  # field :field_definition_id, type: Moped::BSON::ObjectId
  # validates_presence_of :field_definition_id

  # field :value, type: String

  # def parent_field_set
  #   @parent_field_set ||= FieldSet.where("field_definitions._id" => field_definition_id).first
  # end

  # def field_definition
  #   @field_definition ||= parent_field_set.nil? ? nil : parent_field_set.field_definitions.detect{|fd| fd._id == field_definition_id}
  # end

end