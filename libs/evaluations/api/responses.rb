module CASE
  module Evaluations
    class Responses < Grape::API

      namespace :responses do

        before do 
          @set ||= Set.find(params[:set_id])
        end

        desc "Gets responses for the evaluation set"
        get "/", root: :responses do 
          # don't give out all responses unless permitted 
          if !params[:own] and !@set.public_responses and current_user != @set.user
            return []
          end
          responses = @set.responses
          if params[:question_id]
            responses = responses.where(question_id: params[:question_id])
          end
          if params[:case_id]
            responses = responses.where(case_id: params[:case_id])
          end
          if params[:user_id]
            responses = responses.where(user_id: params[:user_id])
          end
          if params[:own] and current_user
            responses = responses.where(user_id: current_user.id)
          end
          if params[:aggregate] 
            CASE::Evaluations.aggregate(responses, @set.questions )
          else
            responses
          end
        end

        desc "Creates an evaluation response"
        params do 
          requires :response
        end
        post do
          authenticate!
          params[:response][:user_id] = current_user.id
          Response.create!(params[:response])
        end

        route_param :response_id do
          before do 
            @response ||= Response.find(params[:response_id])
          end

          desc "Gets an evaluation response"
          get do 
            @response
          end

          desc "Updates an evaluation response"
          params do 
            requires :response
          end
          put do
            authorize_owner!(@response.user)
            @response.update_attributes!(params[:response])
          end

          desc "Destroys an evaluation response"
          delete do
            authorize_owner!(@response.user)
            @response.destroy!
          end


        end
      end

    end
  end
end