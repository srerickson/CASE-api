module CASE
  module Evaluations
    class EvaluationQuestion < ActiveRecord::Base
      belongs_to :evaluation_set, inverse_of: :evaluation_questions,
                                  class_name: '::CASE::Evaluations::EvaluationSet'

      has_many :evaluation_responses, dependent: :destroy, 
                                      inverse_of: :evaluation_question,
                                      class_name: '::CASE::Evaluations::EvaluationResponse'
    end
  end
end