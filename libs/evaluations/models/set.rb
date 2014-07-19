module CASE
  module Evaluations
    class Set < ActiveRecord::Base
      belongs_to :user
      has_many :questions,  -> {order(:order)},
                            dependent: :destroy, 
                            inverse_of: :set,
                            class_name: '::CASE::Evaluations::Question'

      has_many :responses, through: :questions,
                           class_name: '::CASE::Evaluations::Response'

      has_many :cases, through: :responses


      accepts_nested_attributes_for :questions, allow_destroy: true

      def aggregates
        CASE::Evaluations.aggregate(responses, questions)
      end

    end
  end
end

