module CASE
  module Evaluations
    class EvaluationSets < Grape::API

      namespace :evaluation_sets do
        get do 
          EvaluationSet.all 
        end
      end
      
    end

  end
end