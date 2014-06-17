class Schema  < ActiveRecord::Base 


  validates_presence_of :name

  validate :field_sets_exist?

  def field_sets
    FieldSet.find field_set_ids
  end


  protected

  def field_sets_exist?
    begin
      self.field_sets
    rescue ActiveRecord::RecordNotFound => e
      errors.add(:field_set_ids, e.message)
    end
  end


end