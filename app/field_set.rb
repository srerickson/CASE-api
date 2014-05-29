class FieldSet < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :field_definitions, dependent: :destroy

  # def schemas
  #   Schema.where("field_set_ids" => self._id )
  # end
  
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