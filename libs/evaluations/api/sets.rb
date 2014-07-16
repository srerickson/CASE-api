require 'compact_case_serializer'

module CASE
  module Evaluations
    class Sets < Grape::API

      namespace :sets do

        desc "Gets all evaluation sets"
        get "/", each_serializer: CompactSetSerializer do 
          Set.all 
        end

        desc "Creates an evaluation set"
        params do
          requires :set
        end
        post do 
          Set.create!(params[:set])
        end

        route_param :set_id do 

          before do 
            @set ||= Set.find(params[:set_id])
          end

          desc "Gets an evaluation set"
          get do 
            @set
          end

          desc "Gets cases evaluated with the evaluation set"
          get :cases, each_serializer: ::CompactCaseSerializer, root: :cases do 
            if params[:own] and current_user
              Case.joins(responses: :set)
                  .where(responses: {user_id: current_user.id})
                  .where(sets: {id: @set.id})
                  .uniq
            else
              @set.cases
            end
          end

          desc "Gets responses for the evaluation set"
          get :responses, root: :responses do 
            if params[:question_id]
              responses ||= @set.responses
              responses = responses.where(question_id: params[:question_id])
            end
            if params[:case_id]
              responses ||= @set.responses
              responses = responses.where(case_id: params[:case_id])
            end
            if params[:user_id]
              responses ||= @set.responses
              responses = responses.where(user_id: params[:user_id])
            end
            if params[:own] and current_user
              responses ||= @set.responses
              responses = responses.where(user_id: current_user.id)
            end
            if params[:aggregate] 
              CASE::Evaluations.aggregate(responses, @set.questions )
            else
              responses
            end
          end

          desc "Updates an evaluation set"
          params do
            requires :set
          end
          put do 
            @set.update_attributes!(params[:set])
          end

          desc "Destroys and evaluation set"
          delete do 
            @set.destroy! 
          end 

          mount CASE::Evaluations::Questions
        end

      end
      
    end

  end
end