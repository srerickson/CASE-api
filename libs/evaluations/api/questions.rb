# Should be mounted within the the set's endpoint 

module CASE
  module Evaluations
    class Questions < Grape::API

      namespace :questions do

        params do
          requires :set_id
        end

        before do 
          @set ||= Set.find(params[:set_id])
        end

        desc "Gets all evaluation questions for an evaluation set"
        get do 
          @set.questions
        end

        desc "Creates an evaluation question"
        params do 
          requires :question
        end
        post do
          authorize_owner!(@set.user)
          @set.questions.create(params[:question])
        end


        route_param :question_id do
          before do 
            @question ||= @set.questions.find(params[:question_id])
          end

          desc "Gets an evaluation question"
          get do 
            @question
          end

          desc "Updates an evaluation question"
          params do 
            requires :question
          end
          put do
            authorize_owner!(@set.user)
            params[:question].delete(:response_option_params)
            @question.update_attributes!(params[:question])
          end

          desc "Destroys an evaluation question"
          delete do
            authorize_owner!(@set.user)
            @question.destroy!
          end


        end
      end
    end
  end
end