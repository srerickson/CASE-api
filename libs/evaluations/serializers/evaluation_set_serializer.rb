module CASE
  module Evaluations
    class EvaluationSetSerializer < ActiveModel::Serializer
      attributes :id, :name, :locked, :public_responses
      has_many :evaluation_questions
    end
  end
end