module CASE
  module Evaluations
    class Set < ActiveRecord::Base
      belongs_to :user
      has_many :questions, dependent: :destroy, 
                           inverse_of: :set,
                           class_name: '::CASE::Evaluations::Question'

      has_many :responses, through: :questions,
                           class_name: '::CASE::Evaluations::Response'
    end
  end
end

