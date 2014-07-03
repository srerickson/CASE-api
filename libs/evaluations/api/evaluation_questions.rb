module CASE
  module Evaluations
    class EvaluationQuestions < Grape::API

      namespace :evaluation_questions do
        get do 
          if @evaluation_set
            @evaluation_set.evaluation_questions
          end
        end
      end
      
    end

  end
end