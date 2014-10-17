class Case < ActiveRecord::Base

  validates_presence_of :name

  has_many :field_values, dependent: :destroy, inverse_of: :case
  has_many :field_definitions, through: :field_values
  has_many :schemas, -> { uniq },through: :field_definitions

  # FIXME: make this dynamic dependin on whether evaluations 
  # module is used
  has_many :responses, class_name: "::CASE::Evaluations::Response"

  has_many :uploads, as: :parent, dependent: :destroy, inverse_of: :parent

  mount_uploader :image, CaseImageUploader

end