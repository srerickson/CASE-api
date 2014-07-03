module CASE
  module Evaluations
    class ResponseSerializer < ActiveModel::Serializer

      attributes  :id, 
                  :question_id,
                  :case_id, 
                  :user_id,
                  :answer,
                  :comment,
                  :created_at, 
                  :updated_at

      # has_one :case, serializer: CompactCaseSerializer   
      # has_one :user
      # has_one :question  

    end
  end
end