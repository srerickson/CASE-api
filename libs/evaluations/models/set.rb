module CASE
  module Evaluations
    class Set < ActiveRecord::Base
      belongs_to :user
      has_many :questions, dependent: :destroy, 
                           inverse_of: :set,
                           class_name: '::CASE::Evaluations::Question'

      has_many :responses, through: :questions,
                           class_name: '::CASE::Evaluations::Response'

      has_many :cases, -> { uniq }, through: :responses

      def summary
        results = []
        groups = self.responses.group("responses.case_id")
                     .group("responses.question_id")
                     .group("responses.answer").count

        cases.all.pluck(:id).each do |c|
          case_groups = groups.select{|k,v| k[0] == c }
          questions.each do |q|
            question_groups = case_groups.select{|k,v| k[1] == q.id }
            result = {}
            result[:case_id] = c
            result[:question_id] = q.id
            q.response_options.each_key do |k|
              result[k] = question_groups[[c,q.id,k.to_i]] || 0
            end
            results << result
          end
        end
        results 
      end



    end
  end
end

