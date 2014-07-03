module CASE
  module Evaluations
    class Question < ActiveRecord::Base
      belongs_to :set, inverse_of: :questions,
                       class_name: '::CASE::Evaluations::Set'

      has_many :responses, dependent: :destroy, 
                           inverse_of: :question,
                           class_name: '::CASE::Evaluations::Response'
    end
  end
end