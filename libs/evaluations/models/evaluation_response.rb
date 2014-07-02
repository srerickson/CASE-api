module CASE
  module Evaluations
    class EvaluationResponse < ActiveRecord::Base
      belongs_to :user
      belongs_to :case #kase?
      belongs_to :evaluation_question, class_name: '::CASE::Evaluations::EvaluationQuestion'
      validates_presence_of :case, :evaluation_question
    end
  end
end