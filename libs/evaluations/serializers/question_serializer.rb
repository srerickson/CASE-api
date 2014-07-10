module CASE
  module Evaluations
    class QuestionSerializer < ActiveModel::Serializer
      
      attributes :id, 
                 :question,
                 :param, 
                 :position, 
                 :is_subquestion, 
                 :response_options
    end
  end
end