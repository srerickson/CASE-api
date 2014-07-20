module CASE
  module Evaluations
    class CompactSetSerializer < ActiveModel::Serializer
      attributes :id, :name, :locked, :public_responses, :user_id
      has_many :questions
    end
  end
end