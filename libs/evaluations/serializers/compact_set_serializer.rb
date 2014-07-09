module CASE
  module Evaluations
    class CompactSetSerializer < ActiveModel::Serializer
      attributes :id, :name, :locked, :public_responses
      has_many :questions
    end
  end
end