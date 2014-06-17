class Case < ActiveRecord::Base

  validates_presence_of :name
  has_many :field_values, dependent: :destroy, inverse_of: :case

end