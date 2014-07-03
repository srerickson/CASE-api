module CASE
  module Evaluations
    class SetSerializer < ActiveModel::Serializer
      attributes :id, :name, :locked, :public_responses
      has_many :questions
    end
  end
end