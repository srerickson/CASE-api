class FieldSet < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :field_definitions, dependent: :destroy, inverse_of: :field_set

  # def schemas
  #   Schema.where("field_set_ids" => self._id )
  # end
  
  accepts_nested_attributes_for :field_definitions, allow_destroy: true

  before_destroy :remove_from_schemas

  def schemas
    Schema.where("%{id} = ANY (field_set_ids)" % {id: id})
    #where('tags @> ARRAY[?]', ['ruby', 'development'])
  end


  protected

  def remove_from_schemas
    schemas.each{ |s| s.update_attributes(field_set_ids: s.field_set_ids - [id]) }
  end


end