module CASE
  module Evaluations
    class API < Grape::API

      format :json
      formatter :json, Grape::Formatter::ActiveModelSerializers

      namespace :evaluation_sets do
        get do 
          EvaluationSet.all 
        end
      end
      
    end

  end
end