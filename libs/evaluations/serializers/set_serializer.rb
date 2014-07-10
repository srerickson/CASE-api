module CASE
  module Evaluations
    class SetSerializer < CompactSetSerializer

      attributes :aggregates

      def aggregates
        object.aggregates
      end

    end
  end
end