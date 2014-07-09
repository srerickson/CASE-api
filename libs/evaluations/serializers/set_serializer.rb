module CASE
  module Evaluations
    class SetSerializer < CompactSetSerializer

      attributes :aggregates

      def aggregates
        object.summary
      end

    end
  end
end