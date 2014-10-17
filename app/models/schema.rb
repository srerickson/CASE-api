
class Schema  < ActiveRecord::Base 

  has_many :field_definitions, dependent: :destroy
  has_many :field_values, through: :field_definitions
  has_many :cases, through: :field_values

  belongs_to :user 

  # # DEPRECATED -- keeping for migration, but will be removed
  # has_many :field_sets, -> {order(:order)},
  #                       dependent: :destroy, 
  #                       inverse_of: :schema


  validates_presence_of :name #, :param
  validate :layout_fields_are_defined
  validate :no_duplicate_fields_in_layout

  accepts_nested_attributes_for :field_definitions, allow_destroy: true


  def layout_field_params
    @layout_field_params = nil if changed.include? "layout"
    if layout.is_a? Array
      @layout_field_params ||= self.layout.map{ |fields| fields['field_definitions'] }.flatten
    elsif layout.is_a? Hash
      @layout_field_params ||= layout['field_definitions']
    else
      @layout_field_params ||= []
    end
    @layout_field_params
  end


  protected


  def layout_fields_are_defined
    diff = layout_field_params - field_definitions.map(&:param)    
    errors.add(:layout, "includes fields that aren't part of the schema: #{diff.join(', ')}") if !diff.empty?
  end

  def no_duplicate_fields_in_layout
    fs = layout_field_params
    duplicates = fs.select{ |f| fs.count(f) > 1 }.uniq
    errors.add(:layout, "includes duplicate fields: #{ duplicates.join(', ') }") if !duplicates.empty?
  end

end