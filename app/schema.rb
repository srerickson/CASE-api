class Schema
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :description, type: String
  field :field_set_ids, type: Array # of FieldSet ObjectIds

  validates :name, presence: true

  # TODO - validated field_sets are all correct type   

  validate :field_set_ids_are_object_ids


  protected

  def field_set_ids_are_object_ids
    self.field_set_ids ||= []
    self.field_set_ids.each_with_index do |fs_id,i|
      unless fs_id.is_a? Moped::BSON::ObjectId
        begin
          self.field_set_ids[i] = Moped::BSON::ObjectId.from_string(fs_id)
        rescue Moped::Errors::InvalidObjectId => e
          errors.add(:field_set_ids, e.message)
        end
      end
    end   
  end


end