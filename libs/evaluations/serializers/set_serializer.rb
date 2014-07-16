module CASE
  module Evaluations
    class SetSerializer < CompactSetSerializer

      # attributes :aggregates

      # def aggregates
      #   # only show aggregate if Set is public or user is set's owner 
      #   if object.public_responses or (scope and object.user_id == scope.id)
      #     object.aggregates
      #   end
      # end

    end
  end
end