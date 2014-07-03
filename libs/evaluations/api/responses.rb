module CASE
  module Evaluations
    class Responses < Grape::API

      namespace :responses do

        desc "Gets all evaluation responses for a case"
        get do 
          if params[:question_id]
            responses ||= Response.all 
            responses = responses.where(question_id: params[:question_id])
          end
          if params[:case_id]
            responses ||= Response.all 
            responses = responses.where(case_id: params[:case_id])
          end
          if params[:user_id]
            responses ||= Response.all 
            responses = responses.where(user_id: params[:user_id])
          end
          responses
        end

        desc "Creates an evaluation response"
        params do 
          requires :response
        end
        post do 
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
            @response.update_attributes!(params[:response])
          end

          desc "Destroys an evaluation response"
          delete do 
            @response.destroy!
          end


        end
      end

    end
  end
end