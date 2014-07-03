module CASE
  module Evaluations
    class EvaluationSets < Grape::API

      namespace :evaluation_sets do

        get do 
          EvaluationSet.all 
        end

        route_param :evaluation_set_id do 

          before do 
            @evaluation_set = EvaluationSet.find(params[:evaluation_set_id])
          end

          get do 
            @evaluation_set
          end
          mount CASE::Evaluations::EvaluationQuestions
        end

      end
      
    end

  end
end