
class Schema  < ActiveRecord::Base 

  has_many :field_sets, -> {order(:order)},
                        dependent: :destroy, 
                        inverse_of: :schema

  has_many :field_definitions, through: :field_sets

  ## These don't work because of https://github.com/rails/rails/issues/13677
  ## (can't do uniq) 
  #
  # has_many :field_values, through: :field_definitions
  # has_many :cases, through: :field_values

  belongs_to :user 

  validates_presence_of :name, :param

  accepts_nested_attributes_for :field_sets, allow_destroy: true


  def cases 
    Case.uniq.joins(:schemas).merge(Schema.where(id: self.id ))
  end


end