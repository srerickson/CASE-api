module CASE
  module Evaluations
    class EvaluationSet < ActiveRecord::Base
      belongs_to :user
      has_many :evaluation_questions, dependent: :destroy, 
                                      inverse_of: :evaluation_set,
                                      class_name: '::CASE::Evaluations::EvaluationQuestion'

      has_many :evaluation_responses, through: :evaluation_questions,
                                      class_name: '::CASE::Evaluations::EvaluationResponse'
    end
  end
end

