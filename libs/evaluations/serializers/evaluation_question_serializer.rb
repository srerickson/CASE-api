module CASE
  module Evaluations
    class EvaluationQuestionSerializer < ActiveModel::Serializer
      
      attributes :id, 
                 :question, 
                 :position, 
                 :is_subquestion, 
                 :response_options
    end
  end
end