module CASE
  module Evaluations
    class QuestionSerializer < ActiveModel::Serializer
      
      attributes :id, 
                 :question,
                 :param, 
                 :order, 
                 :is_subquestion, 
                 :response_options,
                 :response_option_params

    end
  end
end