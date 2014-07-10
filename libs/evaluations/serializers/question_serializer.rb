module CASE
  module Evaluations
    class QuestionSerializer < ActiveModel::Serializer
      
      attributes :id, 
                 :question,
                 :param, 
                 :position, 
                 :is_subquestion, 
                 :response_options,
                 :response_option_params

    end
  end
end