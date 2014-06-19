
class Schema  < ActiveRecord::Base 

  has_many :field_sets, -> {order(:order)},
                        dependent: :destroy, 
                        inverse_of: :schema

  belongs_to :user 
  validates_presence_of :name, :param

  accepts_nested_attributes_for :field_sets, allow_destroy: true


end